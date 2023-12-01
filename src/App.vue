<template>
  <v-app id="inspire">
    <v-card-title>
      <v-toolbar theme="dark" class="elevation-2" color="cyan" title="vuetify-money" />
    </v-card-title>
    <v-card-text>
      <v-container>
        <v-row>
          <v-col cols="4" sm="4" md="4">
            <vuetify-money
              v-model="value1"
              :label="label1"
              :readonly="readonly1"
              :disabled="disabled1"
              :variant="variant1"
              :clearable="clearable1"
              :valueWhenIsEmpty="valueWhenIsEmpty1"
              :options="options1"
              :properties="properties1"
              :valueOptions="valueOptions1"
              @CustomMinEvent="value1 = $event"
              @CustomMaxEvent="value1 = $event"
            />
            Parent v-model: {{ value1 }}
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="4" sm="4" md="4">
            <vuetify-money
              v-model="value2"
              :label="label2"
              :readonly="readonly2"
              :disabled="disabled2"
              :variant="variant2"
              :clearable="clearable2"
              :valueWhenIsEmpty="valueWhenIsEmpty2"
              :options="options2"
              :properties="properties2"
            />
            Parent v-model: {{ value2 }}
          </v-col>
        </v-row>
      </v-container>
    </v-card-text>
  </v-app>
</template>

<script>
import VuetifyMoney from "./components/VuetifyMoney.vue";

export default {
  name: "app",
  components: {
    "vuetify-money": VuetifyMoney
  },
  data: () => ({
    value1: "1250.03",
    label1: "Valor pt-BR",
    readonly1: false,
    disabled1: false,
    variant1: 'outlined',
    clearable1: true,
    valueWhenIsEmpty1: "", // "0" or "" or null
    valueOptions1: {
      min: 1000,
      minEvent: "CustomMinEvent",
      max: 10000,
      maxEvent: "CustomMaxEvent"
    },
    options1: {
      locale: "pt-BR",
      prefix: "R$",
      suffix: "",
      length: 11,
      precision: 2
    },
    properties1: {
      hint: "my hint 1"
    },

    value2: "1250.03",
    label2: "Value en-US",
    readonly2: false,
    disabled2: false,
    variant2: 'outlined',
    clearable2: true,
    valueWhenIsEmpty2: "", // "0" or "" or null
    options2: {
      locale: "en-US",
      prefix: "U$",
      suffix: "",
      length: 7,
      precision: 2
    },
    properties2: {
      hint: "my hint 2"
    }
  })
};
</script>
