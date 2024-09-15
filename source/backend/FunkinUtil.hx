package backend;

class FunkinUtil {
    public function new() {}

    // Converts BPM to milliseconds per beat
    public static function bpmToMs(bpm:Float):Float {
        if (bpm <= 0) return 0;
        return 60000 / bpm;
    }

    // Converts milliseconds per beat to BPM
    public static function msToBpm(ms:Float):Float {
        if (ms <= 0) return 0;
        return 60000 / ms;
    }

    // Distance between two notes in milliseconds
    public static function noteDist(note1:Float, note2:Float, bpm:Float):Float {
        var msPerBeat = bpmToMs(bpm);
        return Math.abs(note1 - note2) * msPerBeat;
    }

    // Score multiplier based on accuracy percentage
    public static function scoreMult(acc:Float):Float {
        if (acc >= 100) return 1.25;
        if (acc >= 90) return 1.1;
        if (acc >= 80) return 1.05;
        return 1; // Default
    }

    // Hit timing window in milliseconds based on BPM
    public static function timingWin(bpm:Float, win:Float):Float {
        return win * bpmToMs(bpm);
    }

    // Check if a note is within the hit timing window
    public static function isHit(noteTime:Float, hitTime:Float, bpm:Float, win:Float):Bool {
        return Math.abs(noteTime - hitTime) <= timingWin(bpm, win);
    }

    // Timing offset in milliseconds from the start of the song
    public static function timingOffset(hitTime:Float, bpm:Float):Float {
        return hitTime * bpmToMs(bpm);
    }

    // Note position based on time and BPM
    public static function notePos(time:Float, bpm:Float, offset:Float = 0):Float {
        return time * bpmToMs(bpm) + offset;
    }

    // Converts milliseconds to beats
    public static function msToBeats(ms:Float, bpm:Float):Float {
        return ms / bpmToMs(bpm);
    }

    // Converts beats to milliseconds
    public static function beatsToMs(beats:Float, bpm:Float):Float {
        return beats * bpmToMs(bpm);
    }

    // Calculates the average time between notes
    public static function avgNoteTime(noteTimes:Array<Float>):Float {
        if (noteTimes.length < 2) return 0;
        var total:Float = 0;
        for (i in 1...noteTimes.length) {
            total += noteTimes[i] - noteTimes[i - 1];
        }
        return total / (noteTimes.length - 1);
    }

    // Calculates the tempo change factor between two BPM values
    public static function tempoFactor(oldBPM:Float, newBPM:Float):Float {
        if (oldBPM <= 0 || newBPM <= 0) return 1;
        return newBPM / oldBPM;
    }

    // Converts a note duration in beats to milliseconds
    public static function noteDuration(beats:Float, bpm:Float):Float {
        return beatsToMs(beats, bpm);
    }

    // Converts milliseconds to note duration in beats
    public static function msToNoteDur(ms:Float, bpm:Float):Float {
        return msToBeats(ms, bpm);
    }
}
