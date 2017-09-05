# ConTeXt-Chinese

Using Microsoft Office Chinese TrueType Fonts in ConTeXt

*Usage in Linux:*
Use command: `source ./font_import.sh`

This command will download fonts into current directory, it will export
variable `OSFONTDIR` where ConTeXt is looking for font files. Fonts will be
registered and translated with ConTeXt, check output PDF, that everything works
as expected.

## Test files

* `test_mschinese.ctex` – uses provided typescript `mschinese.ctex`.
* `test_mscore_mschinese.ctex` – uses typescript in ConTeXt distribution, it is 
   defined in file `type-imp-mscore.mkiv` and calls typescript _mscore_.
* `sample_chinese.ctex` – contains Chinese text.

