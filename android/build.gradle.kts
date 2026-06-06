allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// flutter_stripe's stripe_android plugin declares `com.stripe:stripe-android-issuing-push-provisioning`
// as a `compileOnly` dependency because its Kotlin sources (EphemeralKeyProvider, PushProvisioningProxy)
// reference those classes directly. The module therefore MUST stay on the compile classpath, otherwise
// `:stripe_android:compileReleaseKotlin` fails with "Unresolved reference 'pushProvisioning'".
//
// That module transitively pulls the gated `com.google.android.gms:play-services-tapandpay` artifact,
// which is not published to public Maven repos and breaks release resolution. This app does not use
// Stripe Issuing / push provisioning, and the TapAndPay integration is reached purely via reflection
// (TapAndPayProxy uses Class.forName), so excluding only the tapandpay artifact is safe.
subprojects {
    configurations.all {
        exclude(group = "com.google.android.gms", module = "play-services-tapandpay")
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
