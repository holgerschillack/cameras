<template>
  <div ref="videoContainer" class="relative h-full w-full" @click="toggleFullScreen">
    <img :src="streamUrl" alt="Camera Stream" class="h-full w-full object-contain" />
  </div>
</template>

<script>
export default {
  name: "VideoStream",
  props: {
    streamUrl: {
      type: String,
      required: true,
    },
    fullScreen: {
      type: Boolean,
      default: false,
    },
  },
  watch: {
    fullScreen: function (newVal) {
      if (newVal) {
        this.goFullScreen();
      } else {
        this.exitFullScreen();
      }
    },
  },
  methods: {
    toggleFullScreen() {
      this.$emit("toggle");
    },
    goFullScreen() {
      if (this.$refs.videoContainer.requestFullscreen) {
        this.$refs.videoContainer.requestFullscreen();
      } else if (this.$refs.videoContainer.mozRequestFullScreen) {
        // Firefox
        this.$refs.videoContainer.mozRequestFullScreen();
      } else if (this.$refs.videoContainer.webkitRequestFullscreen) {
        // Chrome, Safari and Opera
        this.$refs.videoContainer.webkitRequestFullscreen();
      } else if (this.$refs.videoContainer.msRequestFullscreen) {
        // IE/Edge
        this.$refs.videoContainer.msRequestFullscreen();
      }
    },
    exitFullScreen() {
      if (
        document.fullscreenElement ||
        document.webkitIsFullscreen ||
        document.mozFullScreen ||
        document.msFullscreenElement
      ) {
        if (document.exitFullscreen) {
          document.exitFullscreen();
        } else if (document.mozCancelFullScreen) {
          // Firefox
          document.mozCancelFullScreen();
        } else if (document.webkitExitFullscreen) {
          // Chrome, Safari and Opera
          this.$refs.videoContainer.webkitExitFullscreen();
        } else if (document.msExitFullscreen) {
          // IE/Edge
          document.msExitFullscreen();
        }
      }
    },
  },
};
</script>
