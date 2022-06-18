add_cus_dep('glo', 'gls', 0, 'makeglossaries');
add_cus_dep('acn', 'acr', 0, 'makeglossaries');
sub makeglossaries{
  system( "makeglossaries \"$_[0]\"" );
}

add_cus_dep('idx', 'ind', 0, 'makeindex');
sub makeindex{
  system("makeindex \"$_[0].idx\"");
}

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
$clean_ext .= ' %R.ist %R.xdy';
