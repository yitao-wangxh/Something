Shader "Custom/MyWater" {						//定义了一个着色器，名称为MyWater
	Properties {								//属性列表,用来指定这段代码将有哪些输入				
		_MainTex ("Base (RGB)", 2D) = "white" {}//定义一个2D纹理属性，默认白色
		_Aim1("Aim1",Vector) = ( 3, 0, 3, -2.5) //波源位置
		_Aim2("Aim2",Vector) = ( 5, 0, -5, 2.0)      
		_Aim3("Aim3",Vector) = (-3, 0, -3, 1.0)      
		_Aim4("Aim4",Vector) = (-5, 0, 5,  0.5)
		_High("High",Float) = 1
	}
	SubShader {									//子着色器
		Pass{									//通道

			CGPROGRAM							//开始标记
			#pragma vertex verf					//定义顶点着色器
			#pragma fragment frag				//定义片元着色器
			
			#include "UnityCG.cginc"			//引用Unity自带的函数库

			sampler2D _MainTex;					//2D纹理属性
			float4 _Aim1;
			float4 _Aim2;
			float4 _Aim3;
			float4 _Aim4;
			float4 _MainTex_ST;
			float _High;

			struct v2f {						//定义一个结构体
				float4 pos:POSITION;			//声明顶点位置
				float2 uv:TEXCOORD0;		//声明纹理
			};
			v2f verf(appdata_base v)			//顶点着色器
			{
				v2f o;							//声明一个结构体对象
				//计算当前顶点与_Aim1、_Aim2、_Aim3、_Aim4的距离
				float dis1 = distance(v.vertex.xyz,_Aim1.xyz);
				float dis2 = distance(v.vertex.xyz,_Aim2.xyz);
				float dis3 = distance(v.vertex.xyz,_Aim3.xyz);
				float dis4 = distance(v.vertex.xyz,_Aim4.xyz);
				//计算当前顶点的高度
				float H = sin(dis1*_Aim1.w+_Time.z *_High)/5;	//计算正弦波的高度
				H += sin(dis2*_Aim2.w + _Time.z*_High)/10;	//叠加正弦波的高度
				H += sin(dis3*_Aim3.w + _Time.z*_High)/15;	//叠加正弦波的高度
				H += sin(dis4*_Aim4.w + _Time.z*_High)/10;	//叠加正弦波的高度
				o.uv = TRANSFORM_TEX(v.texcoord,_MainTex);	

				o.pos = mul(_Object2World,v.vertex);			//将顶点转换到世界坐标的矩阵
				o.pos.y = H;									//顶点的Y值赋为H
				o.pos = mul(_World2Object,o.pos);				//将顶点转换到自身坐标的矩阵
				o.pos = mul(UNITY_MATRIX_MVP,o.pos);			//计算顶点位置
				
				return o;										//返回顶点着色器对象
			}
			fixed4 frag(v2f i):COLOR
			{
				float4 texCol = tex2D(_MainTex,i.uv);	//获取顶点对应UV的染色
				
				return texCol;						//返回顶点染色
			}
			ENDCG									//着色器结束标志
		} 
	} 
	FallBack "Diffuse"								//降级着色器（备用的着色器）
}