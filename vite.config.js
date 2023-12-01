// Plugins
import vue from "@vitejs/plugin-vue";
import vuetify from "vite-plugin-vuetify";

// Utilities
import { defineConfig } from "vite";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue({}),
    // https://github.com/vuetifyjs/vuetify-loader/tree/master/packages/vite-plugin#readme
    vuetify({})
  ],
  define: { "process.env": {} },
  resolve: {
    extensions: [".js", ".json", ".vue"]
  },
  server: {
    port: 3000
  }
});
