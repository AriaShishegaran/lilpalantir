Response Modes[](#response-modes "Permalink to this heading")
==============================================================

Right now, we support the following options:

* `refine`: ***create and refine*** an answer by sequentially going through each retrieved text chunk.This makes a separate LLM call per Node/retrieved chunk.

**Details:** the first chunk is used in a query using the`text\_qa\_template` prompt. Then the answer and the next chunk (as well as the original question) are usedin another query with the `refine\_template` prompt. And so on until all chunks have been parsed.

If a chunk is too large to fit within the window (considering the prompt size), it is split using a `TokenTextSplitter`(allowing some text overlap between chunks) and the (new) additional chunks are considered as chunksof the original chunks collection (and thus queried with the `refine\_template` as well).

Good for more detailed answers.
* `compact` (default): similar to `refine` but ***compact*** (concatenate) the chunks beforehand, resulting in less LLM calls.

**Details:** stuff as many text (concatenated/packed from the retrieved chunks) that can fit within the context window(considering the maximum prompt size between `text\_qa\_template` and `refine\_template`).If the text is too long to fit in one prompt, it is split in as many parts as needed(using a `TokenTextSplitter` and thus allowing some overlap between text chunks).

Each text part is considered a “chunk” and is sent to the `refine` synthesizer.

In short, it is like `refine`, but with less LLM calls.
* `tree\_summarize`: Query the LLM using the `summary\_template` prompt as many times as needed so that all concatenated chunkshave been queried, resulting in as many answers that are themselves recursively used as chunks in a `tree\_summarize` LLM calland so on, until there’s only one chunk left, and thus only one final answer.

**Details:** concatenate the chunks as much as possible to fit within the context window using the `summary\_template` prompt,and split them if needed (again with a `TokenTextSplitter` and some text overlap). Then, query each resulting chunk/split against`summary\_template` (there is no ***refine*** query !) and get as many answers.

If there is only one answer (because there was only one chunk), then it’s the final answer.

If there are more than one answer, these themselves are considered as chunks and sent recursivelyto the `tree\_summarize` process (concatenated/splitted-to-fit/queried).

Good for summarization purposes.
* `simple\_summarize`: Truncates all text chunks to fit into a single LLM prompt. Good for quicksummarization purposes, but may lose detail due to truncation.
* `no\_text`: Only runs the retriever to fetch the nodes that would have been sent to the LLM,without actually sending them. Then can be inspected by checking `response.source\_nodes`.
* `accumulate`: Given a set of text chunks and the query, apply the query to each textchunk while accumulating the responses into an array. Returns a concatenated string of allresponses. Good for when you need to run the same query separately against each textchunk.
* `compact\_accumulate`: The same as accumulate, but will “compact” each LLM prompt similar to`compact`, and run the same query against each text chunk.

See [Response Synthesizer](../../querying/response_synthesizers/root.html) to learn more.

