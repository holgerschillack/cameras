# Cameras Viewer for Frigate NVR

A Dockerized Vue.js app that provides a grid view for live camera streams from a Frigate NVR system. It uses Vite for faster and leaner development builds, and Tailwind CSS for utility-first CSS management. By clicking on each camera stream, you can inspect the stream in full resolution. The smaller grid video streams only have half the resolution to save traffic and load on the Frigate server.

## Features

- Grid view of live camera streams
- View camera streams in full resolution by clicking on the streams
- Smaller grid video streams with half resolution for optimal resource usage
- Dockerized application for easy deployment
- Built with Vue.js 3, Vite and Tailwind CSS for modern, efficient, and scalable frontend development

## Prerequisites

- Docker installed on your system
- A running Frigate NVR system

## Usage

1. Create a `docker-compose.yml` file in your system with the following content:

   ```yaml
   version: "3.9"
   services:
     cameras:
       image: meastw/cameras
       environment:
         - VITE_FRIGATE_API_URL=http://192.168.178.69:5000/api/
         - VITE_CAMERA_NAMES=Camera1,Camera2
         - VITE_CAMERA_RES=1080,1440
       ports:
         - "8080:80"
       restart: unless-stopped
   ```

2. Replace the placeholders in the environment variables (`VITE_FRIGATE_API_URL`, `VITE_CAMERA_NAMES`, and `VITE_CAMERA_RES`) with your own settings.

   - `VITE_FRIGATE_API_URL`: The URL of your Frigate API.
   - `VITE_CAMERA_NAMES`: A comma-separated list of your camera names.
   - `VITE_CAMERA_RES`: A comma-separated list of your cameras' vertical resolutions.

3. Run `docker-compose up` in the directory of your `docker-compose.yml` file.

4. Access the application at `http://localhost:8080`.

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.

## License

[MIT](LICENSE)
