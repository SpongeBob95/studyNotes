<template>
  <div id="vuperess-theme-blog__global-layout">
    <Header />
    <MobileHeader
      :is-open="isMobileHeaderOpen"
      @toggle-sidebar="isMobileHeaderOpen = !isMobileHeaderOpen"
    />
	<div class="home-layout">
		<div class="title-img"
			:style="{backgroundImage:'url('+require('../../assets/img/bg-grey.jpg')+')'}">
			All things are difficult before they are easy
		</div>
		<div class="content">
			<div class="content-left" @click="isMobileHeaderOpen = false">
				<div class="classification-layout" v-if="!isTags">
					<Author />
					
					<!-- <router-view name='tag'>
						<DefaultGlobalLayout1  />
					</router-view> -->
					<!-- <FrontmatterKey /> -->
				</div>
			</div>
			<div class="content-right" @click="isMobileHeaderOpen = false">
				<DefaultGlobalLayout />
			</div>
		</div>
	</div>
	<!-- <div class="content-wrapper" @click="isMobileHeaderOpen = false" v-if="!isHome">
	  <DefaultGlobalLayout />
	</div> -->
	
    <Footer />
  </div>
  	
</template>

<script>
import GlobalLayout from '@app/components/GlobalLayout.vue'
import Header from '@theme/components/Header.vue'
import MobileHeader from '@theme/components/MobileHeader.vue'
import Footer from '@theme/components/Footer.vue'
import Classification from '@theme/global-components/Classification.vue'
import Author from '@theme/components/Author.vue';
import Tags from '@theme/components/Tags.vue';
import FrontmatterKey from '@theme/layouts/FrontmatterKey.vue'

export default {
  components: {
    DefaultGlobalLayout: GlobalLayout,
	FrontmatterKey,
    Header,
    MobileHeader,
    Footer,
	Author,
	Tags
  },

  data() {
    return {
      isMobileHeaderOpen: false,
	  isTags: false,
	  tags: [],
    }
  },

  mounted() {
	this.tags = this.$frontmatterKey ? this.$frontmatterKey : this.tags;
	this.global();
	console.log(this.$frontmatterKey)
    this.$router.afterEach(() => {
      this.isMobileHeaderOpen = false;
	  this.isTags = /\/tag\/$/.test(this.$route.path);
	  console.log(this.$route.path)
	  this.tags = this.$frontmatterKey ? this.$frontmatterKey : this.tags;
	  console.log('tags', this.tags);
	  // this.global();
	})
  },
  
  methods: {
	global() {
		let vm = this;
		setTimeout(() => {
		  console.log('tags', vm.tags);
		},100)
	}
  }
}
</script>

<style lang="stylus">
.content-wrapper
  padding 160px 15px 80px 15px
  min-height calc(100vh - 80px - 60px - 160px)
  max-width 740px
  margin 0 auto
	
.content-home 
	max-width 100%
	min-height calc(100vh - 145px)
	padding-top 80px
	margin 0 auto
.home-layout 
	padding 80px 0 0 0
	
.title-img
	background-position center
	background-size cover
	display block
	position relative
	// top 0px
	// bottom 0
	// left 0
	// right 0
	// z-index 0
	height 380px
	text-align center
	display flex
	align-items center
	justify-content center
	font-size 24px
	
.content
	display: flex;
	align-items: flex-start;
	margin: 20px auto 0;
	max-width: 1126px;
	
.content-left
	width 300px
	margin: 0 20px 0px 0;
	position sticky
	top 100px
	// background #008000
	// border 1px solid black


.content-right
	padding 0 15px 80px 15px
	min-height calc(100vh - 80px - 60px)
	max-width 780px
	// margin 0 auto

.classification-layout
	transition all .3s
	// margin-left 15px
	flex 0 0 300px
	height auto
	box-shadow: 0px 0px 5px #d0cece;
	border-radius .25rem
	box-sizing border-box
	padding 0 15px
	background #FFFFFF

@media (max-width: $MQMobile)
  .content-right
     padding 0px 15px 20px 15px
     min-height calc(100vh - 20px - 60px)
  .content-wrapper
     padding 100px 15px 20px 15px
     min-height calc(100vh - 20px - 60px - 100)
  
  .content-left
    display none
</style>
