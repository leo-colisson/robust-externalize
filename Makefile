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
