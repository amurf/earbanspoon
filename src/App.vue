<script setup lang="ts">
// volume-meter.js
import atanProcessorUrl from "./vumeter.js?url";

const peakVolume = $ref(0);
const currentVolume = $ref(null);
const volumeData = $ref([]);
const averageVolume = $ref(0);

const isRecording = $ref(false);

let audioContext;
let source;

function start() {
  peakVolume = 0;
  volumeData = [];
  averageVolume = 0;
  currentVolume = null;

  navigator.mediaDevices
    .getUserMedia({ audio: true, video: false })
    .then(async function (mediaStream) {
      audioContext = new AudioContext();

      await audioContext.audioWorklet.addModule(atanProcessorUrl);
      source = audioContext.createMediaStreamSource(mediaStream);

      isRecording = true;

      const node = new AudioWorkletNode(audioContext, "vumeter");
      node.port.onmessage = (event) => {
        if (event.data.volume) {
          currentVolume = Math.round(event.data.volume * 200);
          volumeData.push(currentVolume);
          if (currentVolume > peakVolume) peakVolume = currentVolume;
        }
      };

      source.connect(node).connect(audioContext.destination);
    });
}

function stop() {
  audioContext.close();
  source.disconnect();
  isRecording = false;
  averageVolume = Math.floor(
    volumeData.reduce((sum, current) => sum + current) / volumeData.length
  );
}
</script>

<template>
  <button @click="start" v-if="!isRecording">Start</button>
  <button @click="stop" v-if="isRecording">Stop</button>

  <h1 v-if="isRecording">Current: {{ currentVolume }}</h1>
  <template v-if="volumeData.length && !isRecording">
    <h1>Peak: {{ peakVolume }}</h1>
    <h1>Average {{ averageVolume }}</h1>
  </template>

  <!-- <Navbar /> -->
  <!-- <PageHeader /> -->
  <!-- <RouterView /> -->
</template>

<style scoped></style>
