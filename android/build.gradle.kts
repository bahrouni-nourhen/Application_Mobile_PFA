// AJOUTE CES LIGNES TOUT EN HAUT :
plugins {
    id("com.google.gms.google-services") version "4.4.2" apply false
}

// LE RESTE DE TON FICHIER RESTE IDENTIQUE :
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
// ... (ne touche pas à ce qui suit)

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
