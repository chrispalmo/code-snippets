# Import/Export Moom Config
ref: https://manytricks.com/osticket/kb/faq.php?id=53

1. Quit Moom on both Macs (cannot sync -- only suitable for one-off duplication)
2. On source Mac:
```bash
defaults export com.manytricks.Moom ~/Desktop/moom.plist
```
3. On target Mac:
```bash
defaults import com.manytricks.Moom ~/Desktop/moom.plist
```
