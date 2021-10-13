wget -r -np -nH -A.tar.gz --cut-dirs=2 http://phrack.org/archives/tgz/ -P ./tar/

mkdir issues/
cd tar/

for i in $(ls -1 *.tar.gz); do
    issue=${i%%.*};
    newdir=$issue;
    mkdir $newdir;
    tar -xzvf $i -C $newdir;
    cd $newdir;
    for j in $(ls -1 *.txt); do
        phile=${j%%.*};
        cupsfilter $phile.txt > $phile.pdf
    done
    pdfunite $(ls -v *.pdf) $issue.pdf
    cp $issue.pdf ../../issues/
    cd ..
done

cd ..
rm -rf tar/
