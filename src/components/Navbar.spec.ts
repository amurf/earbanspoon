import { describe, it, expect } from "vitest";

import { mount } from "@vue/test-utils";
import Navbar from "./Navbar.vue";

// TODO: move to module, create test setup helper
import { createI18n } from "vue-i18n";
const messages = Object.fromEntries(
  Object.entries(
    import.meta.glob<{ default: any }>("../../locales/*.y(a)?ml", {
      eager: true,
    })
  ).map(([key, value]) => {
    const yaml = key.endsWith(".yaml");
    return [key.slice(14, yaml ? -5 : -4), value.default];
  })
);

const i18n = createI18n({
  legacy: false,
  locale: "en",
  messages,
});

describe("Navbar", () => {
  it("renders properly", () => {
    const wrapper = mount(Navbar, { global: { plugins: [i18n] } });
    expect(wrapper.text()).toContain("Home");
  });
});
