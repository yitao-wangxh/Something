using UnityEngine;
using System.Collections;

public class GUIswift : MonoBehaviour {
    public Material mat;            //材质变量
    public AudioSource flow;
	// Use this for initialization
	void Start () {
        WaveOn();
    }
	
	// Update is called once per frame
	void Update () {}

    void OnGUI()
    {
        if (GUI.Button(new Rect(10, 10, 58, 30), "有波纹"))
        {
            WaveOn();
        }
        if (GUI.Button(new Rect(10, 50, 58, 30), "无波纹"))
        {
            WaveOff();
        }
    }
    void WaveOn() {
        Debug.Log("显示水波纹");

        mat.SetVector("_Aim1", new Vector4(3, 0, 3, -2.5f));
        mat.SetVector("_Aim2", new Vector4(5, 0, -5, 2f));
        mat.SetVector("_Aim3", new Vector4(-3, 0, -3, 1f));
        mat.SetVector("_Aim4", new Vector4(-5, 0, 5, 0.5f));

        mat.SetFloat("_High", 1);
        flow.Play();

    }
    void WaveOff() {
        Debug.Log("关闭水波纹");

        mat.SetVector("_Aim1", new Vector4(3, 0, 3, 0));
        mat.SetVector("_Aim2", new Vector4(5, 0, -5, 0));
        mat.SetVector("_Aim3", new Vector4(-3, 0, -3, 0));
        mat.SetVector("_Aim4", new Vector4(-5, 0, 5, 0));

        mat.SetFloat("_High", 0);
        flow.Stop();
    }
}
