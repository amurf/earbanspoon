<script setup lang="ts">
const { t } = useI18n();
const route = useRoute();
</script>

<template>
  <header>
    <h1>{{ t(`page-header.${route.name}`) }}</h1>
  </header>
</template>
