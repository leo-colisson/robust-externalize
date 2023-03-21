# LaTeX: Robust externalize

## Why this library?

TikZ is great, but TikZ figures often takes time to compile (it can easily take a few seconds per picture). This can become really annoying with documents containing many pictures, as the compilation can take multiple minutes (my thesis needed roughly 30mn to compile as it contains many tiny figures, and LaTeX needs to compile the document multiple times before converging to the final result). When using online LaTeX providers (e.g. overleaf), this can be a real pain as you are unable to process your document due to timeouts. TikZ has an externalize library to pre-compile these images on the first run. Even if this library is quite simple to use, it has multiple issues:
- If you add a picture before existing pre-compiled pictures, the pictures that are placed after will be recompiled from scratch. This can be mitigated by manually adding a prefix to each picture, but it is really not practical to use.
- To compile each picture, LaTeX reads the document's preambule and needs to process (quickly) the whole document. In large documents (or in documents relying on many packages), this can result in a significant loading time, sometimes much bigger than the time to compile the document without the externalize library: for instance, if the document takes 10 seconds to be loaded, and if you have 200 pictures that take 1s each to be compiled, the first compilation with the TikZ's externalize library will take roughly half an hour instead of 3mn without the library. And if you add a single picture at the beginning of the document… you need to restart everything from scratch. For these reasons, I was not even able to compile my thesis with TikZ's library in a reasonable time.
- Little purity is enforced: if a macro changes before a pre-compiled picture that uses this macro, the figure will not be updated. This can result to different documents depending on whether the cache is cleared or not.
- According to some maintainers of TikZ, "[the code of the externalization library is mostly unreadable gibberish](https://github.com/pgf-tikz/pgf/issues/758#issuecomment-565778508)", and therefore most of the above issues are unlikely to be solved in a foreseable future.

## What is our library doing?

The role of our library is to overcome the aforementioned weaknesses of TikZ's externalize library using a simple and flexible code base.

## FAQ

**Is it working on overleaf?**
Yes: overleaf automatically compiles documents with `shell-escape`, so nothing special needs to be done there.
