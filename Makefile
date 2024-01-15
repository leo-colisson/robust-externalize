ctan_package: doc/robust-externalize.pdf doc/robust-externalize.tex robust-externalize.sty README.md
	rm -rf build_ctan
	mkdir -p build_ctan/robust-externalize
	cp $^ build_ctan/robust-externalize/
# On CTAN the file won't be in doc:
	sed -i 's#`doc/#`#g' build_ctan/robust-externalize/README.md
	sed -i 's#\\input{../robust-externalize.sty}#\\usepackage{robust-externalize}#g' build_ctan/robust-externalize/robust-externalize.tex
	cd build_ctan && zip robust-externalize.zip -r robust-externalize && mv robust-externalize.zip ..

doc/robust-externalize.pdf: doc/robust-externalize.tex
	cd doc && latexmk robust-externalize

arxiv: doc/robust-externalize.tex doc/gnuplot-lua-tikz-common.tex robust-externalize.sty doc/gnuplot-lua-tikz.sty doc/gnuplot-lua-tikz.tex doc/zx-calculus.sty doc/tikzlibraryzx-calculus.code.tex doc/common_inputs.tex doc/gnuplot_data.dat doc/robust-externalize-robExt-all-figures.txt doc/mylib.py doc/ltxdoc.cls doc/robExt-prepare-for-arxiv.py
	rm -rf build_ctan
	mkdir -p build_ctan/robust-externalize/create-latest-cache
	cp -r $^ doc/robustExternalize/ build_ctan/robust-externalize/create-latest-cache
# On arXiv the file won't be in doc:
	sed -i 's#%\pdfoutput=1#\pdfoutput=1#g' build_ctan/robust-externalize/create-latest-cache/robust-externalize.tex
	sed -i 's#\\input{../robust-externalize.sty}#\\usepackage{robust-externalize}#g' build_ctan/robust-externalize/create-latest-cache/robust-externalize.tex
# the "recompile" option needs shell-escape, so we disable it on arxiv by printing only the source code and not the
# result
	sed -i 's#%TURN_INTO_CODE_ONLY_ARXIV#code only#g' build_ctan/robust-externalize/create-latest-cache/robust-externalize.tex
#	cd build_ctan/robust-externalize/create-latest-cache && (yes | python robExt-remove-old-figures.py)
# As a consequence, the page number might change, and some cached picture might be invalid now, so we compile this version locally once. But before we backup this folder:
	cp -r build_ctan/robust-externalize/create-latest-cache build_ctan/robust-externalize/final-version
	cd build_ctan/robust-externalize/create-latest-cache && latexmk -shell-escape robust-externalize.tex
# cp build_ctan/robust-externalize/create-latest-cache/robust-externalize-robExt-all-figures.txt build_ctan/robust-externalize/final-version/robust-externalize-robExt-all-figures.txt
	cp build_ctan/robust-externalize/create-latest-cache/robustExternalize/* build_ctan/robust-externalize/final-version/robustExternalize/
	cd build_ctan/robust-externalize/final-version/ && python robExt-prepare-for-arxiv.py
#	cp build_ctan/robust-externalize/create-latest-cache/robExt-remove-old-figures.py build_ctan/robust-externalize/final-version/robExt-remove-old-figures.py
# ArXiv will remove the .pdf if there is a .tex file. So we need to remove it manually or using backup source for arxiv.
# cd build_ctan/robust-externalize/final-version && xargs -I "{}" mv "robustExternalize/{}" "robustExternalize/{}-backup" < robust-externalize-robExt-all-figures.txt
	cd build_ctan/robust-externalize/final-version && zip robust-externalize-arxiv.zip -r * && mv robust-externalize-arxiv.zip ../../..

