<script setup lang="ts"></script>

<template>
  <TopNav />
  <PageHeader />

  <Suspense>
    <RouterView />
  </Suspense>
</template>

<style scoped></style>
