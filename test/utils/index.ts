import { mount as _mount } from "@vue/test-utils";

import { i18n } from "@/i18n";

export function mount(component, options = {}) {
  const defaultOptions = {
    global: {
      plugins: [i18n],
    },
  };

  return _mount(component, Object.assign(defaultOptions, options));
}
