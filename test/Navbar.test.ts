import { describe, it, expect } from "vitest";
import { mount } from "./utils";
import Navbar from "@/components/Navbar.vue";

describe("Navbar", () => {
  it("renders properly", () => {
    const wrapper = mount(Navbar);
    expect(wrapper.text()).toContain("Home");
  });
});
