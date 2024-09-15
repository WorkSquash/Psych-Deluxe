package backend;

class MathUtil {
    public function new() {}

    public static function clamp(value:Float, min:Float, max:Float):Float {
        if (value < min) return min;
        if (value > max) return max;
        return value;
    }

    public static function lerp(a:Float, b:Float, t:Float):Float {
        return a + t * (b - a);
    }

    public static function map(value:Float, fromMin:Float, fromMax:Float, toMin:Float, toMax:Float):Float {
        return toMin + (value - fromMin) * (toMax - toMin) / (fromMax - fromMin);
    }

    public static function dist(x1:Float, y1:Float, x2:Float, y2:Float):Float {
        var dx = x2 - x1;
        var dy = y2 - y1;
        return Math.sqrt(dx * dx + dy * dy);
    }

    public static function round(value:Float):Int {
        return Math.round(value);
    }

    public static function approxEqual(a:Float, b:Float, tolerance:Float = 0.0001):Bool {
        return Math.abs(a - b) <= tolerance;
    }

    public static function lerpColor(color1:Int, color2:Int, t:Float):Int {
        var r1 = (color1 >> 16) & 0xFF;
        var g1 = (color1 >> 8) & 0xFF;
        var b1 = color1 & 0xFF;
        var r2 = (color2 >> 16) & 0xFF;
        var g2 = (color2 >> 8) & 0xFF;
        var b2 = color2 & 0xFF;
        var r = Math.round(lerp(r1, r2, t));
        var g = Math.round(lerp(g1, g2, t));
        var b = Math.round(lerp(b1, b2, t));
        return (r << 16) | (g << 8) | b;
    }

    public static function isPowerOfTwo(value:Int):Bool {
        return (value > 0) && ((value & (value - 1)) == 0);
    }

    public static function fact(n:Int):Int {
        if (n < 0) return 0;
        var result:Int = 1;
        for (i in 2...n + 1) {
            result *= i;
        }
        return result;
    }

    public static function average(values:Array<Float>):Float {
        if (values.length == 0) return 0;
        var sum:Float = 0;
        for (value in values) {
            sum += value;
        }
        return sum / values.length;
    }

    /*public static function med(values:Array<Float>):Float {
        if (values.length == 0) return 0;
        values.sort();
        var mid:Int = values.length / 2;
        return (values.length % 2 == 0) ? (values[mid - 1] + values[mid]) / 2 : values[mid];
    }*/

    /*public static function isPrime(n:Int):Bool {
        if (n <= 1) return false;
        for (i in 2...Math.sqrt(n) + 1) {
            if (n % i == 0) return false;
        }
        return true;
    }*/

    public static function gcd(a:Int, b:Int):Int {
        while (b != 0) {
            var temp:Int = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    public static function lcm(a:Int, b:Int):Int {
        return Std.int((a * b) / gcd(a, b));
    }

    public static function standardDeviation(values:Array<Float>):Float {
        if (values.length == 0) return 0;
        var mean:Float = average(values);
        var sum:Float = 0;
        for (value in values) {
            var diff:Float = value - mean;
            sum += diff * diff;
        }
        return Math.sqrt(sum / values.length);
    }

    public static function norm(value:Float, min:Float, max:Float):Float {
        return (value - min) / (max - min);
    }

    public static function clampAngle(angle:Float):Float {
        return (angle % 360 + 360) % 360;
    }

    public static function toDegrees(radians:Float):Float {
        return radians * (180 / Math.PI);
    }

    public static function toRadians(degrees:Float):Float {
        return degrees * (Math.PI / 180);
    }
}

class Formulas { //IDK why you would ever need it but just in case here it is... -WorkSquash
    public function new() {}

    // Quadratic Formula: x = (-b ± √(b² - 4ac)) / 2a
    public static function quadFormula(a:Float, b:Float, c:Float):Array<Float> {
        var discriminant:Float = b * b - 4 * a * c;
        if (discriminant < 0) return []; // No real roots
        var sqrtDiscriminant:Float = Math.sqrt(discriminant);
        var x1:Float = (-b + sqrtDiscriminant) / (2 * a);
        var x2:Float = (-b - sqrtDiscriminant) / (2 * a);
        return [x1, x2];
    }

    // Pythagorean Theorem: c = √(a² + b²)
    public static function pythag(a:Float, b:Float):Float {
        return Math.sqrt(a * a + b * b);
    }

    // Distance Formula: d = √((x2 - x1)² + (y2 - y1)²)
    public static function distFormula(x1:Float, y1:Float, x2:Float, y2:Float):Float {
        return Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2));
    }

    // Circle Area: A = πr²
    public static function circleArea(r:Float):Float {
        return Math.PI * r * r;
    }

    // Circle Circumference: C = 2πr
    public static function circleCircum(r:Float):Float {
        return 2 * Math.PI * r;
    }

    // Triangle Area (Heron's Formula): A = √(s(s - a)(s - b)(s - c))
    // where s = (a + b + c) / 2
    public static function triArea(a:Float, b:Float, c:Float):Float {
        var s:Float = (a + b + c) / 2;
        return Math.sqrt(s * (s - a) * (s - b) * (s - c));
    }

    // Slope of a Line: m = (y2 - y1) / (x2 - x1)
    public static function slope(x1:Float, y1:Float, x2:Float, y2:Float):Float {
        if (x2 == x1) throw "Undefined slope (vertical line)";
        return (y2 - y1) / (x2 - x1);
    }

    // Compound Interest: A = P(1 + r/n)^(nt)
    // where P = principal, r = annual interest rate, n = number of times interest applied per time period, t = time periods
    public static function compInt(P:Float, r:Float, n:Int, t:Float):Float {
        return P * Math.pow(1 + r / n, n * t);
    }

    // Simple Interest: A = P(1 + rt)
    // where P = principal, r = annual interest rate, t = time periods
    public static function simpleInt(P:Float, r:Float, t:Float):Float {
        return P * (1 + r * t);
    }

    // Exponential Growth: A = P * e^(rt)
    // where P = initial amount, r = rate, t = time
    public static function expGrowth(P:Float, r:Float, t:Float):Float {
        return P * Math.exp(r * t);
    }
}