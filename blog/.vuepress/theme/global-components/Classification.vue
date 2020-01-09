<template>
	<div class="classification-layout">
		<Author />
		<!-- <Tags /> -->
		<Tags />
	</div>
</template>

<script>
	import Author from '@theme/components/Author.vue';
	import Tags from '@theme/components/Tags.vue';

	export default {
		components: {
			Author,
			Tags,
		},
	}
	  
</script>

<style lang="stylus">
	.classification-layout
		position sticky
		// top 90px
		transition all .3s
		// margin-left 15px
		flex 0 0 300px
		height auto
		box-shadow: 0px 0px 5px #d0cece;
		border-radius .25rem
		box-sizing border-box
		padding 0 15px
		background #FFFFFF
		
</style>
