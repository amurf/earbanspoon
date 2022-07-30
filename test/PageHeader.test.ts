import { describe, it, expect } from "vitest";
import { mount } from "./utils";
import PageHeader from "@/components/PageHeader.vue";

describe("PageHeader", () => {
  it("renders properly", () => {
    const wrapper = mount(PageHeader);
    expect(wrapper.text()).toContain("The page header");
  });
});
