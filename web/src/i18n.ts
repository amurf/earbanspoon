import { createI18n } from "vue-i18n";

const messages = Object.fromEntries(
  Object.entries(
    import.meta.glob<{ default: any }>("../locales/*.yaml", {
      eager: true,
    })
  ).map(([key, value]) => {
    return [key.slice(11, -5), value.default];
  })
);

export const i18n = createI18n({
  legacy: false,
  locale: "en",
  messages,
});
