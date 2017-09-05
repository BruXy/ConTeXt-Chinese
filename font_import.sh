#!/bin/bash
#
# Chinese ConTeXt Font Installation
# =================================
#
# Author: Martin 'BruXy' Bruchanov, bruchy at gmail dot com
#
# Usage: source font_import.sh
#
# -----------------------------------------------------------------------------
#
# Definition of system font path:
#   export OSFONTDIR="/usr/local/share/fonts;$HOME/.fonts"
#
# Additional info:
# http://wiki.contextgarden.net/Fonts_in_LuaTex#How_LuaTeX_handles_system_fonts
#
# How LuaTeX handles fonts:
# http://mirrors.ibiblio.org/CTAN/macros/luatex/generic/luatexja/doc/
#
# Fonts from Microsoft Office:
# ----------------------------
#
# Availaible at: http://archive1.village.virginia.edu/spw4s/fonts/
#
# STSONG.TTF STSong
# STZHONGS.TTF STZhongsong
# STXIHEI.TTF STXihei
# STKAITI.TTF  STKaiti
# STFANGSO.TTF STFangsong
#

# Set OS font path
export OSFONTDIR="$PWD"

# Download fonts
URL=http://archive1.village.virginia.edu/spw4s/fonts
for i in STSONG.TTF STZHONGS.TTF STXIHEI.TTF STKAITI.TTF STFANGSO.TTF
do
    FILE="$OSFONTDIR/$i"
    LOWERCASE=$(tr '[A-Z]' '[a-z]' <<< $i)
    if [ ! -f $FILE  ]
    then
        echo $i not found, downloading...
        curl -o $FILE  "$URL/$i"
    fi
    # Keeping files only upper-case was causing an error, when
    # ConTeXt distribution 'mscore' was used.
    if [ ! -f $LOWERCASE ]
    then
        cp -v $OSFONTDIR/$i $OSFONTDIR/$LOWERCASE
    fi
done

# - Update font database (ConTeXt also should do it automatically)
mtxrun --script fonts --reload

# - Force ConTeXt update font database
context --generate

# Querying font database
# - Command will show font successfully registered in system.
FONTS=( STSong STZhongsong STXihei STKaiti STFangsong )

for font in ${FONTS[*]}
do
    echo "=== Font: $font ==="
    mtxrun --script font --list --all --pattern=${font}*
    #Get useful informations about your fonts by using the --info option. For instance,
    mtxrun --script fonts --list --info --pattern=${font}*
done | tee chinese_fonts.log

# Run test
# 1. Provided typescript
context test_mschinese.ctex

# 2. ConTeXt provided 'mscore' typescript
context test_mscore_mschinese.ctex

