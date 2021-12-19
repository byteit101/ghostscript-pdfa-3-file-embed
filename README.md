# PDF/A-3 (B) Ghostscript File Embedding & Attachment Script

This repo has a script to enable easily embedding files in a PDF/A-3 via Ghostscript. If you do not need PDF/A-3, this can also be used to just embed files too.

These scripts require ghostscript, and as written, ArgyllCMS for the sRGB color profile. The script should run without modification on Debian 10 with `ghostscript` and `argyll` installed. Otherwise, you will need to make changes.

Common changes:
 * Different sRGB path or color space: update `ICCProfile` and `OutputConditionIdentifier`
 * Later version of Ghostscript: `-dNOSAFER` (required for computing the hashes, last modified date, and mime type). Do not use this script on PDF files that you do not trust! 

The script is composed of 5 sections, from top to bottom:
 1. [A PS JSON parser](https://comp.lang.postscript.narkive.com/CtRplAtR/json-reader-writer-in-postscript). 
 2. String concatenate function from [this SO post]( https://stackoverflow.com/a/12379557).
 3. My function definitions to decode the parsed JSON and attach it to the PDF
 4. Slightly modified `PDFA_defs.ps` from the Ghostscript distribution to attach the ICC color profiles and make the document PDF/A
 5. My code to actually load, parse, and insert the attachments
 
# General Usage

Run the sample: `./run-example.sh`.  This re-generates output.pdf.

Valid options to the script are:

 * `-sAttachmentSpec=file.json` (required) Load the attachment specification
 * `-dDefaultRel=/Supplement` (optional) Default relation for attached files. See below. Valid values (from pdf specification): `/Source`, `/Data`, `/Alternative`, `/Supplement`, `/EncryptedPayload`, `/FormData`, `/Schema`, `/Unspecified`. Custom values may be used where none of these entries is appropriate.
 * `-sDefaultTitle="Any Title here"` (optional) Default title if the PDF file doesn't have a title already.

# JSON Attachment Specification

The specification is flexible. If you just want to attach one file with no description, a single string is fine: `"path/to/my/file.png"`. If you want to attach multiple files with no description, an array works too: `["path/file1.png", "path/file2.txt"]`. In these two cases, the `DefaultRel` applies.

If you wish to add a description, you must use the full specification:

```
{
	"/path/to/file1.jpg": {
		"desc": "(optional) my description",
		"rel": "(optional, uses DefaultRel otherwise) Alternative"
	},
	"/path/to/file2.zip": {
		"rel": "EncryptedPayload"
	}
}
```

Note that `rel` lacks the leading `/` that `DefaultRel` has, though the values are otherwise the same.


