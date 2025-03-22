# Understanding `meta.json` and its Fields

## What is `meta.json`?

The `meta.json` file is used to store important metadata about the song or track, such as the title, artist, charter, and language. This file helps the game understand how to display song information and load the correct font or language settings based on the song's characteristics.

### Structure of `meta.json`

The structure of `meta.json` is very simple and contains key information about the song. Here’s an example of a `meta.json` file:

```json
{
    "meta": {
        "title": "Song Title",
        "artist": "Artist Name",
        "charter": "Charter Name",
        "language": "en"
    }
}
```
Each key inside the "meta" block represents a specific piece of information about the song.

Fields in `meta.json`
1. title
Type: String
Description: The title of the song.
Example: `"title": "My Song Title"`

2. artist
Type: String
Description: The name of the artist who made the song.
Example: `"artist": "Famous Artist"`

3. charter
Type: String
Description: The name of the person who charted the song (created the gameplay for the song).
Example: `"charter": "Charter Person"`
4. language
Type: String (Language code)
Description: The language of the song's lyrics. This is important for selecting the correct font and rendering characters that may be unique to the language. The language code follows the ISO 639-1 standard.
**Optional**: If the song is in a Latin-based language like English, French, or Spanish, you don’t need to specify the language. By default, it will assume English (`en`).
Example: `"language": "fr"` (for French)
For languages with non-Latin scripts, such as Chinese, Japanese, Korean, or Arabic, specifying the language is required.

### How Does meta.json Work?
Title: The title field is used to display the song's name in the game. It’s visible to the player when starting the song.
Artist: The artist field tells the game who created the song. This information is often shown next to the song’s title.
Charter: The charter field specifies who created the chart for the song. This is important to acknowledge the person who designed the gameplay for that specific track. The charter name may appear on credits screens or other parts of the game where song-related info is shown.
Language: The language field helps the game load the correct font for the song based on the language it’s written in. For example, if the song has characters like é, ß, or other unique symbols, you should specify the language code (like fr for French).
If the song is in a language that uses the Latin alphabet, you don’t need to specify the language code unless special characters are present.
For non-Latin scripts, such as Japanese, Korean, or Arabic, you must specify the language code.

Example: `meta.json` for a French Song
```json
{
    "meta": {
        "title": "Chanson Magnifique",
        "artist": "Artiste Français",
        "charter": "Charter Person",
        "language": "fr"
    }
}
```
In this case, the song is in French, so the language code fr is included.

Example: `meta.json` for a Japanese Song:
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
For a Japanese song, we specify the language code as ja, and the title and artist are written in Japanese characters.

#### Conclusion
The `meta.json` file is a crucial part of the song’s metadata. It helps the game properly display song titles, artists, chart creators, and load the right font or language settings based on the song's content. By specifying the correct values for each field, you ensure that your song displays properly, and the game handles special characters for different languages.
