<script setup lang="ts">
const { t } = useI18n()
</script>

<template>
  <header>
    <nav>
      <RouterLink to="/">{{ t("navigation.home") }}</RouterLink>
    </nav>
  </header>
</template>
