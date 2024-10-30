#!/bin/bash

# Directories to search (add your desired directories here)
dirs=(~/bin ~/.local/als/bin)  # Replace with actual directories
depth=1  # Depth for the find command

# Directory to save .desktop files
desktop_dir=~/.local/share/applications

# Cleanup old als-desktop files
function cleanup_desktop_files() {
    for desktop_file in "$desktop_dir"/als-desktop-*.desktop; do
        # Extract script name from the desktop filename
        script_name=$(basename "$desktop_file" | sed 's/^als-desktop-\(.*\)\.desktop$/\1/')
        
        # Check if the corresponding script still exists
        script_still_contains=false
        f=$(find "${dirs[@]}" -maxdepth "$depth" -type f -name "$script_name" | head -n 1)
        if [ -f "$f" ] && sed -n '2p' "$f" | grep -qE '^#als-desktop[[:space:]]+(%[fuFU])$'; then
            script_still_contains=true
        fi
        
        # Remove desktop file if script no longer exists
        if [[ "$script_still_contains" == false ]]; then
            rm -f -- "$desktop_file"
            echo "Removed outdated .desktop file: $desktop_file"
        fi
    done
}

# Generate .desktop files for scripts with matching shebang and second line
function generate_desktop_files() {
    find "${dirs[@]}" -maxdepth "$depth" -type f | while read -r script; do
        # Check if file has shebang and matching second line
        if [[ $(head -n 1 "$script") == "#!"* ]]; then
            second_line=$(sed -n '2p' "$script")
            
            if [[ "$second_line" =~ ^#als-desktop[[:space:]]+(%[fuFU])$ ]]; then
                # Extract the argument placeholder (%f, %F, %u, %U)
                placeholder="${BASH_REMATCH[1]}"
                script_name=$(basename "$script")
                desktop_file="$desktop_dir/als-desktop-$script_name.desktop"
                
                # Create .desktop file
                cat > "$desktop_file" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$script_name
Exec=$script_name $placeholder
Icon=konsole
Terminal=false
MimeType=application/x-desktop;inode/directory;application/andrew-inset;application/applixware;application/atom+xml;application/atomcat+xml;application/atomsvc+xml;application/ccxml+xml;application/cu-seeme;application/davmount+xml;application/ecmascript;application/emma+xml;application/epub+zip;application/font-tdpfr;application/gzip;application/x-gzip;application/hyperstudio;application/java-archive;application/java-serialized-object;application/java-vm;application/json;text/json;application/lost+xml;application/mac-binhex40;application/mac-compactpro;application/marc;application/mathematica;application/mathml+xml;text/mathml;application/mbox;application/mediaservercontrol+xml;application/mp4;application/msword;application/mxf;application/octet-stream;application/oda;application/oebps-package+xml;application/ogg;application/onenote;application/patch-ops-error+xml;application/pdf;application/x-pdf;application/pgp-encrypted;application/pgp-signature;application/pics-rules;application/pkcs10;application/pkcs7-mime;application/x-pkcs7-certreqresp;application/x-pkcs7-certificates;application/pkcs7-signature;application/pkix-cert;application/pkix-crl;application/pkix-pkipath;application/pkixcmp;application/pls+xml;application/postscript;application/prql;application/prs.cww;application/rdf+xml;application/reginfo+xml;application/relax-ng-compact-syntax;application/resource-lists+xml;application/resource-lists-diff+xml;application/rls-services+xml;application/rsd+xml;application/rss+xml;application/rtf;application/sbml+xml;application/scvp-cv-request;application/scvp-cv-response;application/scvp-vp-request;application/scvp-vp-response;application/sdp;application/set-payment-initiation;application/set-registration-initiation;application/shf+xml;application/smil+xml;application/sparql-query;application/sparql-results+xml;application/srgs;application/srgs+xml;application/ssml+xml;application/vnd.3gpp.pic-bw-large;application/vnd.3gpp.pic-bw-small;application/vnd.3gpp.pic-bw-var;application/vnd.3gpp2.tcap;application/vnd.3m.post-it-notes;application/vnd.accpac.simply.aso;application/vnd.accpac.simply.imp;application/vnd.acucobol;application/vnd.acucorp;application/vnd.adobe.air-application-installer-package+zip;application/vnd.adobe.xdp+xml;application/vnd.adobe.xfdf;application/vnd.airzip.filesecure.azf;application/vnd.airzip.filesecure.azs;application/vnd.amazon.ebook;application/vnd.americandynamics.acc;application/vnd.amiga.ami;application/vnd.android.package-archive;application/vnd.anser-web-certificate-issue-initiation;application/vnd.anser-web-funds-transfer-initiation;application/vnd.antix.game-component;application/vnd.apple.installer+xml;application/vnd.arastra.swi;application/vnd.audiograph;application/vnd.blueice.multipass;application/vnd.bmi;application/vnd.businessobjects;application/vnd.chemdraw+xml;application/vnd.chipnuts.karaoke-mmd;application/vnd.cinderella;application/vnd.claymore;application/vnd.clonk.c4group;application/vnd.commonspace;application/vnd.contact.cmsg;application/vnd.cosmocaller;application/vnd.crick.clicker;application/vnd.crick.clicker.keyboard;application/vnd.crick.clicker.palette;application/vnd.crick.clicker.template;application/vnd.crick.clicker.wordbank;application/vnd.criticaltools.wbs+xml;application/vnd.ctc-posml;application/vnd.cups-ppd;application/vnd.curl.car;application/vnd.curl.pcurl;application/vnd.data-vision.rdz;application/vnd.debian.binary-package;application/vnd.denovo.fcselayout-link;application/vnd.dna;application/vnd.dolby.mlp;application/vnd.dpgraph;application/vnd.dreamfactory;application/vnd.dynageo;application/vnd.ecowin.chart;application/vnd.enliven;application/vnd.epson.esf;application/vnd.epson.msf;application/vnd.epson.quickanime;application/vnd.epson.salt;application/vnd.epson.ssf;application/vnd.eszigno3+xml;application/vnd.ezpix-album;application/vnd.ezpix-package;application/vnd.fdf;application/vnd.fdsn.mseed;application/vnd.fdsn.seed;application/vnd.flographit;application/vnd.fluxtime.clip;application/vnd.framemaker;application/vnd.frogans.fnc;application/vnd.frogans.ltf;application/vnd.fsc.weblaunch;application/vnd.fujitsu.oasys;application/vnd.fujitsu.oasys2;application/vnd.fujitsu.oasys3;application/vnd.fujitsu.oasysgp;application/vnd.fujitsu.oasysprs;application/vnd.fujixerox.ddd;application/vnd.fujixerox.docuworks;application/vnd.fujixerox.docuworks.binder;application/vnd.fuzzysheet;application/vnd.genomatix.tuxedo;application/vnd.geogebra.file;application/vnd.geogebra.tool;application/vnd.geometry-explorer;application/vnd.gerber;application/vnd.gmx;application/vnd.google-earth.kml+xml;application/vnd.google-earth.kmz;application/vnd.grafeq;application/vnd.groove-account;application/vnd.groove-help;application/vnd.groove-identity-message;application/vnd.groove-injector;application/vnd.groove-tool-message;application/vnd.groove-tool-template;application/vnd.groove-vcard;application/vnd.handheld-entertainment+xml;application/vnd.hbci;application/vnd.hhe.lesson-player;application/vnd.hp-hpgl;application/vnd.hp-hpid;application/vnd.hp-hps;application/vnd.hp-jlyt;application/vnd.hp-pcl;application/vnd.hp-pclxl;application/vnd.hydrostatix.sof-data;application/vnd.hzn-3d-crossword;application/vnd.ibm.minipay;application/vnd.ibm.modcap;application/vnd.ibm.rights-management;application/vnd.ibm.secure-container;application/vnd.iccprofile;application/vnd.igloader;application/vnd.immervision-ivp;application/vnd.immervision-ivu;application/vnd.intercon.formnet;application/vnd.intu.qbo;application/vnd.intu.qfx;application/vnd.ipunplugged.rcprofile;application/vnd.irepository.package+xml;application/vnd.is-xpr;application/vnd.jam;application/vnd.jcp.javame.midlet-rms;application/vnd.jisp;application/vnd.joost.joda-archive;application/vnd.kahootz;application/vnd.kde.karbon;application/vnd.kde.kchart;application/vnd.kde.kformula;application/vnd.kde.kivio;application/vnd.kde.kontour;application/vnd.kde.kpresenter;application/vnd.kde.kspread;application/vnd.kde.kword;application/vnd.kenameaapp;application/vnd.kidspiration;application/vnd.kinar;application/vnd.koan;application/vnd.kodak-descriptor;application/vnd.llamagraphics.life-balance.desktop;application/vnd.llamagraphics.life-balance.exchange+xml;application/vnd.lotus-1-2-3;application/vnd.lotus-approach;application/vnd.lotus-freelance;application/vnd.lotus-notes;application/vnd.lotus-organizer;application/vnd.lotus-screencam;application/vnd.lotus-wordpro;application/vnd.macports.portpkg;application/vnd.mcd;application/vnd.medcalcdata;application/vnd.mediastation.cdkey;application/vnd.mfer;application/vnd.mfmp;application/vnd.micrografx.flo;application/vnd.micrografx.igx;application/vnd.mif;application/vnd.mobius.daf;application/vnd.mobius.dis;application/vnd.mobius.mbk;application/vnd.mobius.mqy;application/vnd.mobius.msl;application/vnd.mobius.plc;application/vnd.mobius.txf;application/vnd.mophun.application;application/vnd.mophun.certificate;application/vnd.mozilla.xul+xml;application/vnd.ms-artgalry;application/vnd.ms-cab-compressed;application/vnd.ms-excel;application/vnd.ms-excel.addin.macroenabled.12;application/vnd.ms-excel.sheet.binary.macroenabled.12;application/vnd.ms-excel.sheet.macroenabled.12;application/vnd.ms-excel.template.macroenabled.12;application/vnd.ms-fontobject;application/vnd.ms-htmlhelp;application/vnd.ms-ims;application/vnd.ms-lrm;application/vnd.ms-pki.seccat;application/vnd.ms-pki.stl;application/vnd.ms-powerpoint;application/vnd.ms-powerpoint.addin.macroenabled.12;application/vnd.ms-powerpoint.presentation.macroenabled.12;application/vnd.ms-powerpoint.slide.macroenabled.12;application/vnd.ms-powerpoint.slideshow.macroenabled.12;application/vnd.ms-powerpoint.template.macroenabled.12;application/vnd.ms-project;application/vnd.ms-word.document.macroenabled.12;application/vnd.ms-word.template.macroenabled.12;application/vnd.ms-works;application/vnd.ms-wpl;application/vnd.ms-xpsdocument;application/vnd.mseq;application/vnd.musician;application/vnd.muvee.style;application/vnd.neurolanguage.nlu;application/vnd.noblenet-directory;application/vnd.noblenet-sealer;application/vnd.noblenet-web;application/vnd.nokia.n-gage.data;application/vnd.nokia.n-gage.symbian.install;application/vnd.nokia.radio-preset;application/vnd.nokia.radio-presets;application/vnd.novadigm.edm;application/vnd.novadigm.edx;application/vnd.novadigm.ext;application/vnd.oasis.opendocument.chart;application/vnd.oasis.opendocument.chart-template;application/vnd.oasis.opendocument.database;application/vnd.oasis.opendocument.formula;application/vnd.oasis.opendocument.formula-template;application/vnd.oasis.opendocument.graphics;application/vnd.oasis.opendocument.graphics-template;application/vnd.oasis.opendocument.image;application/vnd.oasis.opendocument.image-template;application/vnd.oasis.opendocument.presentation;application/vnd.oasis.opendocument.presentation-template;application/vnd.oasis.opendocument.spreadsheet;application/vnd.oasis.opendocument.spreadsheet-template;application/vnd.oasis.opendocument.text;application/vnd.oasis.opendocument.text-master;application/vnd.oasis.opendocument.text-template;application/vnd.oasis.opendocument.text-web;application/vnd.olpc-sugar;application/vnd.oma.dd2+xml;application/vnd.openofficeorg.extension;application/vnd.openxmlformats-officedocument.presentationml.presentation;application/vnd.openxmlformats-officedocument.presentationml.slide;application/vnd.openxmlformats-officedocument.presentationml.slideshow;application/vnd.openxmlformats-officedocument.presentationml.template;application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;application/vnd.openxmlformats-officedocument.spreadsheetml.template;application/vnd.openxmlformats-officedocument.wordprocessingml.document;application/vnd.openxmlformats-officedocument.wordprocessingml.template;application/vnd.osgi.dp;application/vnd.palm;application/vnd.pg.format;application/vnd.pg.osasli;application/vnd.picsel;application/vnd.pocketlearn;application/vnd.powerbuilder6;application/vnd.previewsystems.box;application/vnd.proteus.magazine;application/vnd.publishare-delta-tree;application/vnd.pvi.ptid1;application/vnd.quark.quarkxpress;application/vnd.rar;application/x-rar-compressed;application/vnd.recordare.musicxml;application/vnd.recordare.musicxml+xml;application/vnd.rim.cod;application/vnd.rn-realmedia;application/vnd.route66.link66+xml;application/vnd.seemail;application/vnd.sema;application/vnd.semd;application/vnd.semf;application/vnd.shana.informed.formdata;application/vnd.shana.informed.formtemplate;application/vnd.shana.informed.interchange;application/vnd.shana.informed.package;application/vnd.simtech-mindmapper;application/vnd.smaf;application/vnd.smart.teacher;application/vnd.solent.sdkm+xml;application/vnd.spotfire.dxp;application/vnd.spotfire.sfs;application/vnd.sqlite3;application/x-sqlite3;application/vnd.stardivision.calc;application/vnd.stardivision.draw;application/vnd.stardivision.impress;application/vnd.stardivision.math;application/vnd.stardivision.writer;application/vnd.stardivision.writer-global;application/vnd.sun.xml.calc;application/vnd.sun.xml.calc.template;application/vnd.sun.xml.draw;application/vnd.sun.xml.draw.template;application/vnd.sun.xml.impress;application/vnd.sun.xml.impress.template;application/vnd.sun.xml.math;application/vnd.sun.xml.writer;application/vnd.sun.xml.writer.global;application/vnd.sun.xml.writer.template;application/vnd.sus-calendar;application/vnd.svd;application/vnd.symbian.install;application/vnd.syncml+xml;application/vnd.syncml.dm+wbxml;application/vnd.syncml.dm+xml;application/vnd.tao.intent-module-archive;application/vnd.tmobile-livetv;application/vnd.trid.tpt;application/vnd.triscape.mxs;application/vnd.trueapp;application/vnd.ufdl;application/vnd.uiq.theme;application/vnd.umajin;application/vnd.unity;application/vnd.uoml+xml;application/vnd.vcx;application/vnd.visio;application/vnd.visionary;application/vnd.vsf;application/vnd.wap.sic;application/vnd.wap.slc;application/vnd.wap.wbxml;application/vnd.wap.wmlc;application/vnd.wap.wmlscriptc;application/vnd.webturbo;application/vnd.wordperfect;application/vnd.wqd;application/vnd.wt.stf;application/vnd.xara;application/vnd.xfdl;application/vnd.yamaha.hv-dic;application/vnd.yamaha.hv-script;application/vnd.yamaha.hv-voice;application/vnd.yamaha.openscoreformat;application/vnd.yamaha.openscoreformat.osfpvg+xml;application/vnd.yamaha.smaf-audio;application/vnd.yamaha.smaf-phrase;application/vnd.yellowriver-custom-menu;application/vnd.zul;application/vnd.zzazz.deck+xml;application/voicexml+xml;application/wasm;application/winhlp;application/wsdl+xml;application/wspolicy+xml;application/x-7z-compressed;application/x-abiword;application/x-ace-compressed;application/x-authorware-bin;application/x-authorware-map;application/x-authorware-seg;application/x-bcpio;application/x-bittorrent;application/x-bzip;application/x-bzip2;application/x-cdlink;application/x-chat;application/x-chess-pgn;application/x-cpio;application/x-csh;application/x-debian-package;application/x-director;application/x-doom;application/x-dtbncx+xml;application/x-dtbook+xml;application/x-dtbresource+xml;application/x-dvi;application/x-font-bdf;application/x-font-ghostscript;application/x-font-linux-psf;application/x-font-otf;font/otf;application/x-font-pcf;application/x-font-snf;application/x-font-ttf;application/x-font-type1;application/x-futuresplash;application/x-gnumeric;application/x-gtar;application/x-gzip;application/gzip;application/x-hdf;application/x-java-jnlp-file;application/x-killustrator;application/x-krita;application/x-latex;application/x-mobipocket-ebook;application/x-ms-application;application/x-ms-wmd;application/x-ms-wmz;application/x-ms-xbap;application/x-msaccess;application/x-msbinder;application/x-mscardfile;application/x-msclip;application/x-msdownload;application/x-msmediaview;application/x-msmetafile;application/x-msmoney;application/x-mspublisher;application/x-msschedule;application/x-msterminal;application/x-mswrite;application/x-netcdf;application/x-perl;application/x-pkcs12;application/x-pkcs7-certificates;application/x-python-code;application/x-redhat-package-manager;application/x-rpm;application/x-sh;application/x-shar;application/x-shellscript;application/x-shockwave-flash;application/x-silverlight-app;application/x-stuffit;application/x-stuffitx;application/x-sv4cpio;application/x-sv4crc;application/x-tar;application/x-tcl;application/x-tex;application/x-tex-tfm;application/x-texinfo;application/x-trash;application/x-ustar;application/x-wais-source;application/x-x509-ca-cert;application/x-xfig;application/x-xpinstall;application/xenc+xml;application/xhtml+xml;application/xml;application/xml-dtd;application/xop+xml;application/xslt+xml;application/xspf+xml;application/xv+xml;application/yaml;text/yaml;text/x-yaml;application/x-yaml;application/zip;application/x-zip-compressed;application/zip-compressed;audio/3gpp;video/3gpp;audio/3gpp2;video/3gpp2;audio/aac;audio/x-aac;audio/adpcm;audio/aiff;audio/x-aiff;audio/basic;audio/flac;audio/x-flac;audio/midi;audio/mp4;audio/mpeg;audio/mp3;audio/mpeg3;audio/x-mpeg-3;audio/ogg;audio/opus;audio/vnd.digital-winds;audio/vnd.dts;audio/vnd.dts.hd;audio/vnd.lucent.voice;audio/vnd.ms-playready.media.pya;audio/vnd.nuera.ecelp4800;audio/vnd.nuera.ecelp7470;audio/vnd.nuera.ecelp9600;audio/wav;audio/x-wav;audio/vnd.wave;audio/wave;audio/x-pn-wav;audio/webm;audio/x-aiff;audio/x-matroska;audio/x-mpegurl;audio/x-ms-wax;audio/x-ms-wma;audio/x-pn-realaudio;audio/x-pn-realaudio-plugin;chemical/x-cdx;chemical/x-cif;chemical/x-cmdf;chemical/x-cml;chemical/x-csml;chemical/x-xyz;font/otf;application/x-font-otf;font/woff;font/woff2;gcode;text/x.gcode;text/x-gcode;image/avif;image/bmp;image/cgm;image/g3fax;image/gif;image/heic;image/ief;image/jpeg;image/pjpeg;image/png;image/x-png;image/vnd.mozilla.apng;image/prs.btif;image/svg+xml;image/tiff;image/vnd.adobe.photoshop;image/vnd.djvu;image/vnd.dwg;image/vnd.dxf;image/vnd.fastbidsheet;image/vnd.fpx;image/vnd.fst;image/vnd.fujixerox.edmics-mmr;image/vnd.fujixerox.edmics-rlc;image/vnd.ms-modi;image/vnd.net-fpx;image/vnd.wap.wbmp;image/vnd.xiff;image/webp;image/x-adobe-dng;image/x-canon-cr2;image/x-canon-crw;image/x-cmu-raster;image/x-cmx;image/x-epson-erf;image/x-freehand;image/x-fuji-raf;image/x-icns;image/x-icon;image/x-kodak-dcr;image/x-kodak-k25;image/x-kodak-kdc;image/x-minolta-mrw;image/x-nikon-nef;image/x-olympus-orf;image/x-panasonic-raw;image/x-pcx;image/x-pentax-pef;image/x-pict;image/x-portable-anymap;image/x-portable-bitmap;image/x-portable-graymap;image/x-portable-pixmap;image/x-rgb;image/x-sigma-x3f;image/x-sony-arw;image/x-sony-sr2;image/x-sony-srf;image/x-xbitmap;image/x-xpixmap;image/x-xwindowdump;message/rfc822;model/iges;model/mesh;model/vnd.dwf;model/vnd.gdl;model/vnd.gtw;model/vnd.mts;model/vnd.vtu;model/vrml;text/calendar;text/css;text/csv;application/csv;text/x-csv;application/x-csv;text/x-comma-separated-values;text/comma-separated-values;text/html;text/javascript;application/ecmascript;application/javascript;application/x-ecmascript;application/x-javascript;text/ecmascript;text/javascript1.0;text/javascript1.1;text/javascript1.2;text/javascript1.3;text/javascript1.4;text/javascript1.5;text/jscript;text/livescript;text/x-ecmascript;text/x-javascript;text/markdown;text/x-markdown;text/mathml;application/mathml+xml;text/plain;text/prs.lines.tag;text/richtext;text/sgml;text/tab-separated-values;text/troff;text/uri-list;text/vnd.curl;text/vnd.curl.dcurl;text/vnd.curl.mcurl;text/vnd.curl.scurl;text/vnd.fly;text/vnd.fmi.flexstor;text/vnd.graphviz;text/vnd.in3d.3dml;text/vnd.in3d.spot;text/vnd.sun.j2me.app-descriptor;text/vnd.wap.si;text/vnd.wap.sl;text/vnd.wap.wml;text/vnd.wap.wmlscript;text/x-asm;text/x-c;text/x-fortran;text/x-java-source;text/x-pascal;text/x-python;text/x-setext;text/x-uuencode;text/x-vcalendar;text/x-vcard;video/3gpp;audio/3gpp;video/3gpp2;audio/3gpp2;video/h261;video/h263;video/h264;video/jpeg;video/jpm;video/mj2;video/mp2t;video/mp4;video/mpeg;video/ogg;video/quicktime;video/vnd.fvt;video/vnd.mpegurl;video/vnd.ms-playready.media.pyv;video/vnd.vivo;video/webm;video/x-f4v;video/x-fli;video/x-flv;video/x-m4v;video/x-matroska;video/x-ms-asf;video/x-ms-wm;video/x-ms-wmv;video/x-ms-wmx;video/x-ms-wvx;video/x-msvideo;video/x-sgi-movie;x-conference/x-cooltalk;
EOF
                echo "Generated .desktop file: $desktop_file"
            fi
        fi
    done
}

# Run cleanup and generation functions
cleanup_desktop_files
generate_desktop_files