package dev.fat7i.customertaxi

import android.content.ContentValues
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterFragmentActivity() {

    private val downloadsChannel = "dev.fat7i.customertaxi/downloads"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, downloadsChannel)
                .setMethodCallHandler { call, result ->
                    when (call.method) {
                        "saveToDownloads" -> {
                            val bytes = call.argument<ByteArray>("bytes")
                            val fileName = call.argument<String>("fileName")
                            val mimeType =
                                    call.argument<String>("mimeType") ?: "application/octet-stream"
                            if (bytes == null || fileName.isNullOrBlank()) {
                                result.error(
                                        "INVALID_ARGS",
                                        "bytes and fileName are required",
                                        null
                                )
                                return@setMethodCallHandler
                            }
                            try {
                                result.success(saveToDownloads(bytes, fileName, mimeType))
                            } catch (e: Exception) {
                                result.error("SAVE_FAILED", e.message, null)
                            }
                        }
                        else -> result.notImplemented()
                    }
                }
    }

    /**
     * Writes [bytes] into the public Downloads folder and returns the absolute file path. API 29+
     * uses MediaStore.Downloads (permission-less); API <= 28 writes directly to the public Download
     * dir (relies on the WRITE_EXTERNAL_STORAGE permission declared for <= 28).
     */
    private fun saveToDownloads(bytes: ByteArray, fileName: String, mimeType: String): String {
        val downloadsDir =
                Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val resolver = applicationContext.contentResolver
            val values =
                    ContentValues().apply {
                        put(MediaStore.Downloads.DISPLAY_NAME, fileName)
                        put(MediaStore.Downloads.MIME_TYPE, mimeType)
                        put(MediaStore.Downloads.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
                        put(MediaStore.Downloads.IS_PENDING, 1)
                    }

            val uri =
                    resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
                            ?: throw IllegalStateException("MediaStore insert returned null")

            resolver.openOutputStream(uri)?.use { it.write(bytes) }
                    ?: throw IllegalStateException("Could not open output stream")

            values.clear()
            values.put(MediaStore.Downloads.IS_PENDING, 0)
            resolver.update(uri, values, null, null)

            // MediaStore auto-uniquifies the display name on collision; read it back.
            var savedName = fileName
            resolver.query(uri, arrayOf(MediaStore.Downloads.DISPLAY_NAME), null, null, null)
                    ?.use { c ->
                        if (c.moveToFirst()) {
                            savedName = c.getString(0) ?: fileName
                        }
                    }
            return File(downloadsDir, savedName).absolutePath
        }

        // API <= 28: legacy direct write.
        if (!downloadsDir.exists()) {
            downloadsDir.mkdirs()
        }
        val target = uniqueFile(downloadsDir, fileName)
        target.outputStream().use { it.write(bytes) }
        return target.absolutePath
    }

    private fun uniqueFile(dir: File, fileName: String): File {
        var candidate = File(dir, fileName)
        if (!candidate.exists()) return candidate

        val dot = fileName.lastIndexOf('.')
        val base = if (dot < 0) fileName else fileName.substring(0, dot)
        val ext = if (dot < 0) "" else fileName.substring(dot)
        var i = 1
        while (true) {
            candidate = File(dir, "$base ($i)$ext")
            if (!candidate.exists()) return candidate
            i++
        }
    }
}
