## Overview
This tool offer the quick way to connect to contacts registered in AnyDesk.

The output is an HTML file with search field and links to open your AnyDesk connection quickly.

You can use the HTML file on all devices, as other computers and smartphones.

To connect quickly, the search field have autofocus enabled. So you can load the page and start to type the contact name.

Feel free to do a PR, ask for new features or make suggestions.

## How it works
This tool read AnyDesk config file and search for all registered contacts.

After run, it generates HTML file on `~/anydesk-contacts.html`


## How to use
Download the script and run:
```
gh repo clone antun3s/anydesk-contacts
cd anydesk-contacts
bash anydesk-contacts.sh

```

So, you just need to open HTML on your browser, search your contact and click on it.

If you need to change the output file location, you can easily change the line with `HTMLFILE=`

But, if you want to load AnyDesk config from other location, change line with `ANYDESKCONFIG=`


## Thanks to
- alphadog on [stackoverflow](https://stackoverflow.com/questions/23929235/multi-line-string-with-extra-space-preserved-indentation?newreg=654f2c7060ef4e1aa487480c6f8271fd), used to create a variable with multi-line string
- [W3schools](w3schools), used for create searchabe table on page
