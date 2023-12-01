<template>
  <div>
    <v-text-field
      v-bind="properties"
      v-model="cmpValue"
      :label="label"
      :placeholder="placeholder"
      :readonly="readonly"
      :disabled="disabled"
      :variant="variant"
      :density="density"
      :hide-details="hideDetails"
      :error="error"
      :error-messages="errorMessages"
      :rules="rules"
      :clearable="clearable"
      :bgColor="bgColor"
      :prefix="options.prefix"
      :suffix="options.suffix"
      @keypress="keyPress"
      @blur="onBlur"
    ></v-text-field>
  </div>
</template>

<script>
export default {
  props: {
    modelValue: {
      type: [String, Number],
      default: "0"
    },
    label: {
      type: String,
      default: ""
    },
    placeholder: {
      type: String,
      default: undefined
    },
    readonly: {
      type: Boolean,
      default: false
    },
    density: {
      type: String,
      default: "default"
    },
    error: {
      type: Boolean,
      default: false
    },
    hideDetails: {
      type: [Boolean, String],
      default: false
    },
    errorMessages: {
      type: [Array, String],
      default: () => []
    },
    rules: {
      type: [Array, String],
      default: () => []
    },
    disabled: {
      type: Boolean,
      default: false
    },
    variant: {
      type: String,
      default: "filled"
    },
    clearable: {
      type: Boolean,
      default: false
    },
    bgColor: {
      type: String,
      default: "white"
    },
    valueWhenIsEmpty: {
      type: String,
      default: "" // "0" or "" or null
    },
    valueOptions: {
      type: Object,
      default: function () {
        return {
          min: 0,
          minEvent: "SetValueMin"
        };
      }
    },
    options: {
      type: Object,
      default: function () {
        return {
          locale: "pt-BR",
          prefix: "",
          suffix: "",
          length: 11,
          precision: 2
        };
      }
    },
    // Other v-text-field properties
    properties: {
      type: Object,
      default: function () {
        return {};
      }
    }
  },
  data: () => ({}),
  /*
   v-model="cmpValue": Dessa forma, ao digitar, o valor é atualizado automaticamente no componente pai.
   O valor digitado entra pelo newValue do Set e é emitido para o componente pai.
   the-vue-mask nao funciona corretamente ao incluir valores existentes no componente pai.
  */
  computed: {
    cmpValue: {
      get: function () {
        return this.modelValue !== null && this.modelValue !== ""
          ? this.humanFormat(this.modelValue.toString())
          : this.valueWhenIsEmpty;
      },
      set: function (newValue) {
        this.$emit("update:modelValue", this.machineFormat(newValue));
      }
    }
  },
  methods: {
    humanFormat: function (number) {
      if (isNaN(number)) {
        number = "";
      } else {
        // number = Number(number).toLocaleString(this.options.locale, {maximumFractionDigits: 2, minimumFractionDigits: 2, style: 'currency', currency: 'BRL'});
        number = Number(number).toLocaleString(this.options.locale, {
          maximumFractionDigits: this.options.precision,
          minimumFractionDigits: this.options.precision
        });
      }
      return number;
    },
    machineFormat: function (number) {
      if (number) {
        number = this.clearNumber(number);
        // Ajustar quantidade de zeros à esquerda
        number = number.padStart(parseInt(this.options.precision) + 1, "0");
        // Incluir ponto na casa correta, conforme a precisão configurada
        number =
          number.substring(
            0,
            number.length - parseInt(this.options.precision)
          ) +
          "." +
          number.substring(
            number.length - parseInt(this.options.precision),
            number.length
          );
        if (isNaN(number)) {
          number = this.valueWhenIsEmpty;
        }
      } else {
        number = this.valueWhenIsEmpty;
      }
      if (this.options.precision === 0) {
        number = this.clearNumber(number);
      }
      return number;
    },
    keyPress: function ($event) {
      const key = $event.key;

      if (Number.isNaN(Number(key))) {
        $event.preventDefault();
      }

      if (this.targetLength()) {
        $event.preventDefault();
      }
    },
    // Retira todos os caracteres não numéricos e zeros à esquerda
    clearNumber: function (value) {
      let result = "";
      if (value) {
        let flag = false;
        let arrayValue = value.toString().split("");
        for (var i = 0; i < arrayValue.length; i++) {
          if (this.isInteger(arrayValue[i])) {
            if (!flag) {
              // Retirar zeros à esquerda
              if (arrayValue[i] !== "0") {
                result = result + arrayValue[i];
                flag = true;
              }
            } else {
              result = result + arrayValue[i];
            }
          }
        }
      }
      return result;
    },
    isInteger: function (value) {
      let result = false;
      if (Number.isInteger(parseInt(value))) {
        result = true;
      }
      return result;
    },
    targetLength: function () {
      return (
        Number(this.clearNumber(this.modelValue).length) >=
        Number(this.options.length + this.options.precision)
      );
    },
    onBlur: function () {
      if (
        this.modelValue.length === 0 ||
        parseFloat(this.modelValue) <= this.valueOptions.min
      )
        this.$emit(
          this.valueOptions.minEvent || "SetValueMin",
          this.valueOptions.min
        );

      if (
        this.valueOptions.max &&
        parseFloat(this.modelValue) >= this.valueOptions.max
      )
        this.$emit(
          this.valueOptions.maxEvent || "SetValueMax",
          this.valueOptions.max
        );
    }
  }
};
</script>
