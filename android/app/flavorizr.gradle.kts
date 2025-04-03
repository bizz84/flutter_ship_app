import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.codewithandrea.flutter_ship_app.dev"
            resValue(type = "string", name = "app_name", value = "Flutter Ship Dev")
        }
        create("stg") {
            dimension = "flavor-type"
            applicationId = "com.codewithandrea.flutter_ship_app.stg"
            resValue(type = "string", name = "app_name", value = "Flutter Ship Stg")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.codewithandrea.flutter_ship_app"
            resValue(type = "string", name = "app_name", value = "Flutter Ship")
        }
    }
}