<script>
	import Header from './Header/Header.svelte'
	import Content from './Content/Content.svelte'
</script>

<main>
	<Header />
	<Content />
</main>

<style>
	main {
		--medium-grey: #3e3e3e;
	}

	:global(*) {
		margin: 0;
		padding: 0;
		/* color: #3e3e3e; */
		color: #dbdedf;
	}

	:global(button) {
		margin: 0;
		padding: 0;
	}

	:global(h2) {
		margin: 50px 0 10px;
	}

	:global(h4) {
		font-size: 15px;
	}

	:global(h5, h6) {
    color: #dbdedf;
	}

	:global(p) {
		margin-bottom: 20px;
	}

	:global(body) {
		background-color: #3e3e3e;
		/* background-color: #f96854; */
		padding: 0px;
	}

	@media screen and (max-width: 1300px) {
		:global(p) {
			font-size: 14px;
		}
		:global(h2) {
			margin-top: 25px;
			font-size: 20px;
		}
		:global(h3) {
			font-size: 17px;
		}
		
		:global(h4) {
			font-size: 14px;
		}

		:global(h5) {
			font-size: 12px;
		}
		:global(h6) {
			font-size: 10px;
		}
	}
	
	main {
		display: flex;
		flex-direction: column;
		align-items: center;
		font-family: 'Raleway';
	}
</style>