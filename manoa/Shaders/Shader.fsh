//
//  Shader.fsh
//  manoa
//
//  Created by Emiliano Miranda on 10/21/11.
//  Copyright (c) 2011 Imber Studios LLC. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
