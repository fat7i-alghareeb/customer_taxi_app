allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// flutter_stripe pulls in `stripe-android-issuing-push-provisioning`, which depends on
// the gated `com.google.android.gms:play-services-tapandpay` artifact that is not
// available in public Maven repos and breaks release builds (`:stripe_android:lintVitalAnalyzeRelease`).
// This app does not use Stripe Issuing / push provisioning, so exclude it from every
// subproject. The Stripe plugin loads push provisioning via reflection, so this is safe.
subprojects {
    configurations.all {
        exclude(group = "com.stripe", module = "stripe-android-issuing-push-provisioning")
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
