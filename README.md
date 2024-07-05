# NewsApp

NewsApp es una aplicación de noticias que permite a los usuarios registrarse, iniciar sesión, buscar noticias por título o contenido, ver una lista de usuarios registrados y mostrar la ubicación de un usuario en un mapa. La autenticación se realiza mediante Firebase y la funcionalidad de mapas se proporciona a través de Google Maps.

## Características

- **Registro e inicio de sesión:** Los usuarios pueden registrarse y acceder a la aplicación utilizando Firebase Authentication.
- **Búsqueda de noticias:** Los usuarios pueden buscar noticias por título o contenido en tiempo real.
- **Menú lateral:** El menú lateral incluye una lista de usuarios registrados en la aplicación.
- **Mapa de usuarios:** Al seleccionar un usuario en la lista, se muestra un mapa con la ubicación del usuario seleccionado.

## Requisitos previos

- Xcode 12 o superior
- CocoaPods
- Una cuenta de Firebase con un proyecto configurado
- Una clave de API de Google Maps habilitada para iOS

## Configuración

1. **Clonar el repositorio:**

    ```sh
    git clone https://github.com/tu-usuario/NewsApp.git
    cd NewsApp
    ```

2. **Instalar las dependencias:**

    Asegúrate de tener CocoaPods instalado. Luego, ejecuta:

    ```sh
    pod install
    ```

3. **Configurar Firebase:**

    - Ve a la consola de Firebase y crea un nuevo proyecto.
    - Habilita Firebase Authentication y Firestore en tu proyecto de Firebase.
    - Descarga el archivo `GoogleService-Info.plist` y añádelo a tu proyecto en Xcode.

4. **Configurar la clave de API de Google Maps:**

    - Ve a la consola de Google Cloud y habilita la API de Google Maps SDK para iOS.
    - Obtén tu clave de API y añádela en `AppDelegate.swift`:

    ```swift
    GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
    ```

5. **Configurar permisos de ubicación:**

    Asegúrate de agregar los permisos de ubicación necesarios en tu archivo `Info.plist`:

    ```xml
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>We need your location to show it on the map.</string>
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>We need your location to show it on the map even when the app is in the background.</string>
    ```

## Uso

1. **Registro e inicio de sesión:**

    Al iniciar la aplicación, se te presentará una pantalla de inicio de sesión. Si no tienes una cuenta, puedes registrarte proporcionando un correo electrónico y una contraseña.

2. **Búsqueda de noticias:**

    Una vez que hayas iniciado sesión, puedes buscar noticias por título o contenido utilizando la barra de búsqueda en la parte superior de la pantalla.

3. **Menú lateral:**

    El menú lateral, accesible desde el ícono en la parte superior izquierda, incluye una lista de usuarios registrados en la aplicación. Al seleccionar un usuario, se abrirá un mapa mostrando su ubicación.

## Estructura del Proyecto

- **NewsApp:** Contiene la configuración principal de la aplicación.
- **ViewModels:** Contiene los modelos de vista, incluyendo `NewsViewModel` para gestionar la lógica de las noticias.
- **Views:** Contiene las vistas principales de la aplicación, incluyendo `NewsListView`, `UserListView`, y `UserMapView`.
- **Services:** Contiene los servicios, incluyendo `NewsService` para manejar las peticiones de noticias.
- **Models:** Contiene los modelos de datos, incluyendo `News` y `User`.

## Pruebas Unitarias

El proyecto incluye pruebas unitarias básicas para verificar la funcionalidad del `NewsViewModel` y `UserMapView`. Para ejecutar las pruebas, selecciona el esquema del proyecto en Xcode y elige **Product > Test** o presiona `Cmd + U`.

## Contribuciones

Las contribuciones son bienvenidas. Siéntete libre de abrir un issue o un pull request.

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo `LICENSE` para obtener más información.

