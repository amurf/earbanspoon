import { createApp } from "vue";
import { createPinia } from "pinia";

import App from "./App.vue";
import router from "./router";

import "uno.css";

const app = createApp(App);

import { i18n } from "./i18n";

app.use(createPinia());
app.use(i18n);
app.use(router);

app.mount("#app");
