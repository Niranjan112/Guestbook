<template>
  <div v-if="isDrizzleInitialized" id="app">
    <h1 style="text-align: center">Sign the Guestbook</h1>
    <drizzle-contract-form
      contractName="Guestbook"
      method="signBook"
      :placeholders="['Name']"
      id="inputText"
    />
    <h1 style="text-align: center">Edit Name in Guestbook</h1>
    <drizzle-contract-form
      contractName="Guestbook"
      method="editNames"
      :placeholders="['Guest Number','Edit Name']"
      id="inputText"
    />
    <h2>Guests:</h2>
      <ol v-if="getNames">
        <li v-for="(name, i) in getNames" :key="i">{{ utils.toUtf8(name) }}</li>
      </ol>
  </div>
  <div v-else>
    Loading application....
  </div>
</template>

<script>
import { mapGetters } from "vuex"
export default {
  name: "app",
  computed: {
    ...mapGetters("drizzle", ["drizzleInstance", "isDrizzleInitialized"]),
    ...mapGetters("contracts", ["getContractData"]),
    getNames() {
      let data = this.getContractData({
        contract: "Guestbook",
        method: "getNames"
      });
      if (data === "loading") return false;
      return data
    },
    utils() {
      return this.drizzleInstance.web3.utils
    }
  },
  created() {
    this.$store.dispatch("drizzle/REGISTER_CONTRACT", {
      contractName: "Guestbook",
      method: "getNames",
      methodArgs: []
    })
  }
}
</script>

<style>
#app {
  margin: auto;
  width: 60%;
  border: 3px solid black;
  padding: 10px;
}
h1,h2 {
  text-align: center;
}
#inputText {
  text-align: center;
}
ol {
  text-align: center;
  list-style: inside;
}
</style>