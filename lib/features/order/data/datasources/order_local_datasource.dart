import 'package:injectable/injectable.dart';
import 'package:customertaxi/core/services/objectbox/entities/objectbox_local_cache_entry_entity.dart';
import 'package:customertaxi/core/services/objectbox/objectbox_dao.dart';
import 'package:customertaxi/core/services/objectbox/objectbox_service.dart';
import 'package:customertaxi/features/order/data/models/order_saved_location_cache_model.dart';
import 'package:objectbox/objectbox.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/error/global_error_handler.dart';

@lazySingleton
class OrderLocalDataSource {
  OrderLocalDataSource(ObjectBoxService objectBoxService)
    : _cacheDao = ObjectBoxDao<ObjectBoxLocalCacheEntryEntity>(
        objectBoxService,
      );

  static const String _savedLocationsCacheKey = 'order.saved_locations.v1';
  static const int _maxSavedLocationsCount = 10;

  final ObjectBoxDao<ObjectBoxLocalCacheEntryEntity> _cacheDao;

  Future<List<OrderSavedLocationCacheModel>> removeSavedLocation(String identityKey) {
    return rethrowAsAppException(() {
      printC('[OrderLocalDataSource] removeSavedLocation identity=$identityKey');
      final existing = _toMutableSavedLocations(_readSavedLocationsInternal());
      existing.removeWhere((item) => item.identityKey == identityKey);
      
      final normalized = _normalizeSavedLocations(existing);
      _writeSavedLocationsInternal(normalized);
      return normalized;
    });
  }

  Future<List<OrderSavedLocationCacheModel>> getSavedLocations() {
    return rethrowAsAppException(() {
      final saved = _readSavedLocationsInternal();
      printC(
        '[OrderLocalDataSource] getSavedLocations count=${saved.length} identities=${saved.map((item) => item.identityKey).join('|')}',
      );
      return saved;
    });
  }

  Future<List<OrderSavedLocationCacheModel>> saveSelectedLocation(
    OrderSavedLocationCacheModel selected,
  ) {
    return rethrowAsAppException(() {
      printC(
        '[OrderLocalDataSource] saveSelectedLocation start identity=${selected.identityKey}',
      );
      final existing = _toMutableSavedLocations(_readSavedLocationsInternal());
      final now = DateTime.now().millisecondsSinceEpoch;

      final index = existing.indexWhere(
        (item) => item.identityKey == selected.identityKey,
      );

      printM(
        '[OrderLocalDataSource] saveSelectedLocation loaded existingCount=${existing.length} index=$index',
      );

      if (index >= 0) {
        final current = existing[index];
        printM(
          '[OrderLocalDataSource] saveSelectedLocation update existing pinned=${current.isPinned} touchedAt=${current.touchedAtMillis}',
        );
        existing[index] = current.copyWith(
          latitude: selected.latitude,
          longitude: selected.longitude,
          label: selected.label,
          touchedAtMillis: now,
        );
      } else {
        printM(
          '[OrderLocalDataSource] saveSelectedLocation insert new entry as unpinned',
        );
        existing.add(selected.copyWith(touchedAtMillis: now, isPinned: false));
      }

      final normalized = _normalizeSavedLocations(existing);
      _writeSavedLocationsInternal(normalized);
      final pinnedCount = normalized.where((item) => item.isPinned).length;

      printG(
        '[OrderLocalDataSource] saveSelectedLocation identity=${selected.identityKey} count=${normalized.length} pinnedCount=$pinnedCount identities=${normalized.map((item) => item.identityKey).join('|')}',
      );

      return normalized;
    });
  }

  Future<List<OrderSavedLocationCacheModel>> togglePinnedLocation(
    OrderSavedLocationCacheModel location,
  ) {
    return rethrowAsAppException(() {
      printC(
        '[OrderLocalDataSource] togglePinnedLocation start identity=${location.identityKey}',
      );
      final existing = _toMutableSavedLocations(_readSavedLocationsInternal());
      final now = DateTime.now().millisecondsSinceEpoch;

      final index = existing.indexWhere(
        (item) => item.identityKey == location.identityKey,
      );

      printM(
        '[OrderLocalDataSource] togglePinnedLocation loaded existingCount=${existing.length} index=$index',
      );

      if (index >= 0) {
        final current = existing[index];
        printM(
          '[OrderLocalDataSource] togglePinnedLocation flip pin from=${current.isPinned} to=${!current.isPinned}',
        );
        existing[index] = current.copyWith(
          latitude: location.latitude,
          longitude: location.longitude,
          label: location.label,
          isPinned: !current.isPinned,
          touchedAtMillis: now,
        );
      } else {
        printM('[OrderLocalDataSource] togglePinnedLocation insert as pinned');
        existing.add(location.copyWith(isPinned: true, touchedAtMillis: now));
      }

      final normalized = _normalizeSavedLocations(existing);
      _writeSavedLocationsInternal(normalized);
      final pinnedCount = normalized.where((item) => item.isPinned).length;

      printM(
        '[OrderLocalDataSource] togglePinnedLocation identity=${location.identityKey} count=${normalized.length} pinnedCount=$pinnedCount identities=${normalized.map((item) => item.identityKey).join('|')}',
      );

      return normalized;
    });
  }

  List<OrderSavedLocationCacheModel> _toMutableSavedLocations(
    List<OrderSavedLocationCacheModel> source,
  ) {
    final mutable = List<OrderSavedLocationCacheModel>.from(source);
    printM(
      '[OrderLocalDataSource] mutableSavedCopy sourceCount=${source.length} mutableCount=${mutable.length}',
    );
    return mutable;
  }

  List<OrderSavedLocationCacheModel> _readSavedLocationsInternal() {
    final entry = _readCacheEntryAndRepairDuplicates();
    if (entry == null) {
      printM('[OrderLocalDataSource] readSavedLocations cache entry missing');
      return <OrderSavedLocationCacheModel>[];
    }

    if (entry.value.trim().isEmpty) {
      printM(
        '[OrderLocalDataSource] readSavedLocations cache entry empty objId=${entry.objId}',
      );
      return <OrderSavedLocationCacheModel>[];
    }

    printM(
      '[OrderLocalDataSource] readSavedLocations rawLength=${entry.value.length} updatedAt=${entry.updatedAtMillis}',
    );

    final envelope = OrderSavedLocationsCacheEnvelopeModel.fromRawValue(
      entry.value,
    );

    printM(
      '[OrderLocalDataSource] readSavedLocations decodedItems=${envelope.items.length}',
    );

    final normalized = _normalizeSavedLocations(envelope.items);
    printM(
      '[OrderLocalDataSource] readSavedLocations normalizedCount=${normalized.length}',
    );

    return _toMutableSavedLocations(normalized);
  }

  void _writeSavedLocationsInternal(List<OrderSavedLocationCacheModel> items) {
    final normalized = _normalizeSavedLocations(items);
    final envelope = OrderSavedLocationsCacheEnvelopeModel(items: normalized);
    final rawValue = envelope.toRawValue();
    final now = DateTime.now().millisecondsSinceEpoch;

    printM(
      '[OrderLocalDataSource] writeSavedLocations normalizedCount=${normalized.length} rawLength=${rawValue.length} updatedAt=$now',
    );

    _upsertCacheEntry(rawValue: rawValue, updatedAtMillis: now);
  }

  void _upsertCacheEntry({
    required String rawValue,
    required int updatedAtMillis,
  }) {
    printM(
      '[OrderLocalDataSource] upsertCacheEntry start rawLength=${rawValue.length} updatedAt=$updatedAtMillis',
    );
    try {
      final existingEntry = _readCacheEntryAndRepairDuplicates();
      if (existingEntry != null) {
        printM(
          '[OrderLocalDataSource] upsertCacheEntry update existing objId=${existingEntry.objId} previousUpdatedAt=${existingEntry.updatedAtMillis}',
        );
        existingEntry.value = rawValue;
        existingEntry.updatedAtMillis = updatedAtMillis;
        _cacheDao.put(existingEntry);
        return;
      }

      printM('[OrderLocalDataSource] upsertCacheEntry insert new cache row');

      _cacheDao.put(
        ObjectBoxLocalCacheEntryEntity(
          key: _savedLocationsCacheKey,
          value: rawValue,
          updatedAtMillis: updatedAtMillis,
        ),
      );
      return;
    } on UniqueViolationException catch (error, stackTrace) {
      printY(
        '[OrderLocalDataSource] upsert unique conflict; retrying update error=$error',
      );

      _recoverCacheEntryUpsert(
        rawValue: rawValue,
        updatedAtMillis: updatedAtMillis,
        originalError: error,
        originalStackTrace: stackTrace,
      );
    } on ObjectBoxException catch (error, stackTrace) {
      printR('[OrderLocalDataSource] upsert objectbox error=$error');

      _recoverCacheEntryUpsert(
        rawValue: rawValue,
        updatedAtMillis: updatedAtMillis,
        originalError: error,
        originalStackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      printR('[OrderLocalDataSource] upsert unexpected error=$error');

      _recoverCacheEntryUpsert(
        rawValue: rawValue,
        updatedAtMillis: updatedAtMillis,
        originalError: error,
        originalStackTrace: stackTrace,
      );
    }
  }

  void _recoverCacheEntryUpsert({
    required String rawValue,
    required int updatedAtMillis,
    required Object originalError,
    required StackTrace originalStackTrace,
  }) {
    printY(
      '[OrderLocalDataSource] recovery start originalError=$originalError',
    );

    try {
      final staleIds = _cacheDao
          .getAll()
          .where((entry) => entry.key == _savedLocationsCacheKey)
          .map((entry) => entry.objId)
          .toList();

      if (staleIds.isNotEmpty) {
        _cacheDao.removeMany(staleIds);
        printY(
          '[OrderLocalDataSource] recovery removed stale entries count=${staleIds.length}',
        );
      }

      _cacheDao.put(
        ObjectBoxLocalCacheEntryEntity(
          key: _savedLocationsCacheKey,
          value: rawValue,
          updatedAtMillis: updatedAtMillis,
        ),
      );

      printY(
        '[OrderLocalDataSource] recovery upsert succeeded updatedAt=$updatedAtMillis rawLength=${rawValue.length}',
      );
    } catch (recoveryError, recoveryStackTrace) {
      printR(
        '[OrderLocalDataSource] recovery failed original=$originalError recovery=$recoveryError',
      );
      printR('$recoveryStackTrace');
      Error.throwWithStackTrace(originalError, originalStackTrace);
    }
  }

  ObjectBoxLocalCacheEntryEntity? _readCacheEntryAndRepairDuplicates() {
    final matches =
        _cacheDao
            .getAll()
            .where((entry) => entry.key == _savedLocationsCacheKey)
            .toList()
          ..sort((first, second) {
            final byUpdated = second.updatedAtMillis.compareTo(
              first.updatedAtMillis,
            );
            if (byUpdated != 0) {
              return byUpdated;
            }

            return second.objId.compareTo(first.objId);
          });

    printM(
      '[OrderLocalDataSource] cacheEntryLookup key=$_savedLocationsCacheKey matches=${matches.length}',
    );

    if (matches.isEmpty) {
      return null;
    }

    if (matches.length > 1) {
      for (final duplicate in matches.skip(1)) {
        _cacheDao.removeById(duplicate.objId);
      }
      printY(
        '[OrderLocalDataSource] repaired duplicate cache entries removed=${matches.length - 1}',
      );
    }

    return matches.first;
  }

  List<OrderSavedLocationCacheModel> _normalizeSavedLocations(
    List<OrderSavedLocationCacheModel> source,
  ) {
    printM(
      '[OrderLocalDataSource] normalizeSavedLocations sourceCount=${source.length}',
    );

    if (source.isEmpty) {
      return <OrderSavedLocationCacheModel>[];
    }

    final dedupMap = <String, OrderSavedLocationCacheModel>{};
    var skippedMissingIdentity = 0;
    var replacedDuplicates = 0;

    for (final item in source) {
      if (item.identityKey.trim().isEmpty) {
        skippedMissingIdentity++;
        continue;
      }

      final current = dedupMap[item.identityKey];
      if (current == null) {
        dedupMap[item.identityKey] = item;
        continue;
      }

      final shouldReplace =
          item.touchedAtMillis > current.touchedAtMillis ||
          (item.touchedAtMillis == current.touchedAtMillis && item.isPinned);

      if (shouldReplace) {
        dedupMap[item.identityKey] = item;
        replacedDuplicates++;
      }
    }

    final normalized = dedupMap.values.toList()
      ..sort((first, second) {
        if (first.isPinned != second.isPinned) {
          return first.isPinned ? -1 : 1;
        }

        return second.touchedAtMillis.compareTo(first.touchedAtMillis);
      });

    var trimmedOverflowCount = 0;

    while (normalized.length > _maxSavedLocationsCount) {
      final unpinnedIndex = normalized.lastIndexWhere((item) => !item.isPinned);

      final removeIndex = unpinnedIndex != -1
          ? unpinnedIndex
          : normalized.length - 1;

      normalized.removeAt(removeIndex);
      trimmedOverflowCount++;
    }

    final pinnedCount = normalized.where((item) => item.isPinned).length;
    printM(
      '[OrderLocalDataSource] normalizeSavedLocations resultCount=${normalized.length} pinnedCount=$pinnedCount skippedMissingIdentity=$skippedMissingIdentity replacedDuplicates=$replacedDuplicates trimmedOverflow=$trimmedOverflowCount',
    );

    return normalized;
  }
}
