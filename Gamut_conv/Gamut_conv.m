clc, clear, close all

type = input('Gamut Type ? 1: sRGB; 2: Adobe RGB; 3: DCI-P3; 4: Rec.709; 5: BT.2020 ?','s');

switch (type) 
    case '1'
        R = [0.640; 0.330; 0.03];
        G = [0.300; 0.600; 0.1];
        B = [0.150; 0.060; 0.79];

    case '2'
        R = [0.6400; 0.3300; 0.0300];
        G = [0.2100; 0.7100; 0.0800];
        B = [0.1500; 0.0600; 0.7900];
     
    case '3'
        R = [0.680; 0.320; 0];
        G = [0.265; 0.690; 0.045]; 
        B = [0.150; 0.060; 0.79];
        
    case '4'
        R = [0.6400; 0.3300; 0.0300];
        G = [0.3000; 0.6000; 0.100];
        B = [0.1500; 0.0600; 0.79];
        
    case '5'
        R = [0.708;	0.292; 0];
        G = [0.170;	0.797; 0.033];
        B = [0.131;	0.046; 0.823];
end
%%
R_w = input('Reference White ? 1: A; 2: D65; 3: D50; 4: CWF; 5: TL84; 6: D55; 7: D60','s');

switch (R_w)
    case '1'
        X = 0.44757; Y =0.40745; Z = 1-X-Y;
    case '2'
        X = 0.3127; Y = 0.3290; Z = 1-X-Y;
    case '3'
        X = 0.34567; Y = 0.35850; Z = 1-X-Y;
    case '4'
        X = 0.37208; Y = 0.37529; Z = 1-X-Y;
    case '5'
        X = 0.38052; Y = 0.37713; Z = 1-X-Y;
    case '6'
        X = 0.33242;	Y = 0.34743; Z = 1-X-Y;
    case '7' 
        X = 0.3217; Y = 0.3378; Z = 0.3405;
end
%%      
P = [R G B];
W = [X/Y ; 1 ; Z/Y]; CC = P \ W;
C = [ CC(1,1) 0 0 ; 0 CC(2,1) 0 ; 0 0 CC(3,1)];
NPM = P * C
%%
conv = input('1: RGB2XYZ; 2: XYZ2RGB ?','s');
value = input('Matrix = ?');

switch (conv)
    case '1'
        XYZ = NPM * value';
        x = XYZ(1,:)./sum(XYZ);
        y = XYZ(2,:)./sum(XYZ);
        disp([x; y]')
        
    case '2'
        RGB = inv(NPM) * value';
end