$latex = 'latex -interaction=nonstopmode -shell-escape';
$pdflatex = 'pdflatex -interaction=nonstopmode -shell-escape';
$pdfxelatex = 'xelatex -interaction=nonstopmode -shell-escape';

$clean_ext = "toc log aux out nav snm blg bbl xdv";

push @generated_exts, "cb";
push @generated_exts, "cb2";
push @generated_exts, "spl";
push @generated_exts, "nav";
push @generated_exts, "snm";
push @generated_exts, "tdo";
push @generated_exts, "nmo";
push @generated_exts, "brf";
push @generated_exts, "nlg";
push @generated_exts, "nlo";
push @generated_exts, "nls";
push @generated_exts, "synctex.gz";
push @generated_exts, "run.xml";
