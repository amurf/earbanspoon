<script setup lang="ts">
const { t } = useI18n();
</script>

<template>
  <header>
    <nav class="flex gap-2">
      <RouterLink to="/">{{ t("navigation.home") }}</RouterLink>
      <RouterLink to="/list-all">{{ t("navigation.list-all") }}</RouterLink>
    </nav>
  </header>
</template>
