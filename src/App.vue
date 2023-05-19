<template>
  <div
    class="md:h-screen w-screen flex items-center justify-center overflow-scroll md:overflow-hidden bg-slate-400"
  >
    <div class="p-6 grid sm:grid-cols-1 md:grid-cols-2 md:grid-rows-2 gap-4">
      <div v-for="(camera, i) in cameras" :key="i" class="relative video-max sm:w-full mb-6">
        <p class="text-3xl font-semibold text-gray-900">{{ camera.name }}</p>
        <VideoStream
          v-if="camera.playing"
          :streamUrl="streamUrls[i]"
          :fullScreen="camera.fullScreen"
          @click="toggleFullScreen(i)"
        />
      </div>
    </div>
  </div>
</template>

<script>
import VideoStream from "./components/VideoStream.vue";

export default {
  components: {
    VideoStream,
  },
  data() {
    const frigateApiUrl = import.meta.env.VITE_FRIGATE_API_URL || null;
    const cameraNames = import.meta.env.VITE_CAMERA_NAMES.split(",") || null;
    const cameraRes = import.meta.env.VITE_CAMERA_RES.split(",").map(Number) || null;

    const cameras = cameraNames.map((name, index) => ({
      name,
      verticalRes: cameraRes[index],
      fullScreen: false,
      playing: true,
    }));

    return {
      frigateApiUrl,
      cameras,
    };
  },
  computed: {
    streamUrls() {
      return this.cameras.map((camera) => {
        const verticalRes = camera.fullScreen ? camera.verticalRes : camera.verticalRes / 2;
        return `${this.frigateApiUrl}${camera.name}?h=${verticalRes}`;
      });
    },
  },
  mounted() {
    document.addEventListener("fullscreenchange", this.fullscreenChange);
    console.log("Cameras:", this.cameras);
    console.log("Frigate Api URL:", this.frigateApiUrl);
  },
  beforeDestroy() {
    document.removeEventListener("fullscreenchange", this.fullscreenChange);
  },
  methods: {
    fullscreenChange() {
      if (
        !document.fullscreenElement &&
        !document.webkitIsFullScreen &&
        !document.mozFullScreen &&
        !document.msFullscreenElement
      ) {
        this.cameras.forEach((camera) => {
          camera.fullScreen = false;
          camera.playing = true;
        });
      }
    },
    toggleFullScreen(index) {
      this.cameras.forEach((camera, i) => {
        if (i === index) {
          camera.fullScreen = !camera.fullScreen;
        } else {
          camera.fullScreen = false;
        }
        camera.playing = camera.fullScreen || !this.cameras[index].fullScreen;
      });
    },
  },
};
</script>

<style scoped>
@media (min-width: 768px) {
  .video-max {
    max-width: 45vw;
    max-height: 45vh;
  }
}
</style>
