from markdown_crawler import md_crawl
url = 'https://docs.llamaindex.ai/en/latest/'
print(f'🕸️ Starting crawl of {url}')
md_crawl(
    url,
    max_depth=10,
    num_threads=150,
    base_dir='.',
    valid_paths=['/'],
    target_content = ['article'],
    target_links = ['body'],
    is_domain_match=True,
    is_base_path_match=False,
    is_debug=True
)