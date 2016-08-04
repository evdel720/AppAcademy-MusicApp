module TracksHelper
  
  def ugly_lyrics(lyrics)
    lyrics = lyrics.split(" ")
    lines = lyrics.each_slice(8).to_a
    new_lyric = lines.map { |l| "♫ " + h(l.join(" ")) }.join("\n")
    "<pre>#{new_lyric}</pre>".html_safe
  end
end
