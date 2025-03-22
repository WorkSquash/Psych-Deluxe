Language Codes and How They Work  

Hey there!  

This game supports multiple languages, but not all languages need a special font.  
If your language uses the **Latin alphabet** (like English, French, German, etc.), you **don’t** need to specify a language code.  
However, by default, the game assumes **English (en)**.  

If your language has unique characters (like é in French or ß in German), you should **specify the language code** to ensure proper display.  

### Special Language Codes (Requiring Different Fonts)  

These languages **need** a special font to display correctly:  

- **Simplified Chinese** → `zh-Hans`, `zh-CN`, `zh-SG` (Uses NotoSansSC)  
- **Traditional Chinese** → `zh-Hant`, `zh-TW`, `zh-HK` (Uses NotoSansTC)  
- **Japanese** → `ja`, `jp` (Uses NotoSansJP)  
   - Example: The title "僕の歌" (Boku no uta)  
- **Korean** → `ko`, `kr` (Uses NotoSansKR)  
- **Arabic** → `ar` (Uses NotoSansArabic)  

### Full List of Language Codes  

For a **complete list of all languages and their codes**, check out this link:  
🔗 **[ISO 639-1 Language Codes](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)**  

### Do You Need to Specify a Language Code?  

- **If your language uses the Latin alphabet** (A-Z), you **don’t need to specify a language code** unless you want specific characters to display properly.  
- **If your language is listed under “Special Language Codes”**, you **must** specify it, or the text will not display correctly.  

### Example Usage in meta.json  

If your song is in **Japanese**, your `meta.json` should look like this:  

```json
{
    "meta": {
        "title": "僕の歌",  
        "artist": "クールアーティスト",  
        "charter": "チャーターさん",  
        "language": "ja"
    }
}
```
If it’s in French, and you want accents to show correctly:
```json
{
    "meta": {
        "title": "Chanson Géniale",  
        "artist": "Artiste Cool", 
        "charter": "Charte Cool",  
        "language": "fr"
    }
}
```
If you don’t specify a language, it defaults to English (`en`).
Now you know how language codes work and how to properly include it in your `meta.json`! This helps the game display text correctly.
