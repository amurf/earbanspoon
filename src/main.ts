import { createApp } from "vue";
import { createPinia } from "pinia";
import { createI18n } from "vue-i18n";

import App from "./App.vue";
import router from "./router";

import "uno.css";

const app = createApp(App);

const messages = Object.fromEntries(
  Object.entries(
    import.meta.glob<{ default: any }>("../locales/*.y(a)?ml", {
      eager: true,
    })
  ).map(([key, value]) => {
    const yaml = key.endsWith(".yaml");
    return [key.slice(11, yaml ? -5 : -4), value.default];
  })
);

const i18n = createI18n({
  legacy: false,
  locale: "en",
  messages,
});

app.use(createPinia());
app.use(i18n);
app.use(router);

app.mount("#app");
