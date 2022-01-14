using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class StartMenu : MonoBehaviour
{

    void Start()
    {
        Time.timeScale = 1; 
    }
    public void exit() {
        Application.Quit();
    }

    public void play(string scene_name) {
        SceneManager.LoadScene(scene_name);
    }

    public void mailto(string mail) {
        Application.OpenURL("mailto:"+mail);
    
    }

    public void sound_volume(float volume) {
        PlayerPrefs.SetFloat("volume", volume);
    }
}
