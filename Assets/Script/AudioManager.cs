using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioManager : MonoBehaviour
{
    public static AudioManager instance;

    /*public AudioClip[] Clip;
    [SerializeField]List<AudioSource> Sound = new List<AudioSource>();*/

    private void Awake()
    {
        instance = this;
    }

    // Start is called before the first frame update
    void Start()
    {
        /*Sound.Clear();
        for (int i = 0; i < Clip.Length; i++)
        {
            Sound.Add(gameObject.AddComponent<AudioSource>());
            Sound[i].clip = Clip[i];
        }*/
    }
}
