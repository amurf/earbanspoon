<script setup lang="ts">
import { getReviews } from "@/firestore.js";
const reviews = await getReviews();
</script>

<template>
  {{ reviews }}
</template>
