<template>
  <div class="app-container">
  #[[$END$]]#
  </div>
</template>

<script>
export default {
  name: "${COMPONENT_NAME}",
  comments:{
  },
  data() {
    return {
      //是否为超管
      isAdmin: false,
      //是否为管理员
      isSystem: false,
      // 遮罩层
      loading: true,

    }
  },

  created() {
    this.isAdmin=this.checkRole(['admin']);
    this.isSystem=this.checkRole(['system'])||this.isAdmin;
    this.initComponents();
  },
  mounted() {
    this.initComponents();
  },
  methods:{
    initComponents(){

    },
  }

}
</script>

<style lange='less' scoped>
</style>
