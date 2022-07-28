import { createApp } from "vue";
import { createPinia } from "pinia";
import { createI18n } from "vue-i18n";

import App from "./App.vue";
import router from "./router";

import "uno.css";

const app = createApp(App);

import messages from "../locales/en.yaml";
const i18n = createI18n({
  legacy: false,
  locale: "en",
  messages: { en: messages },
});

app.use(createPinia());
app.use(i18n);
app.use(router);

app.mount("#app");
